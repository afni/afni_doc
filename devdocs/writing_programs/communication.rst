.. _wp_communication:

===================================
Communication: NIML and Live Data
===================================

.. contents:: In this chapter
   :local:

AFNI programs rarely live in isolation.  They exchange datasets on disk, but
they also talk to each other and to the GUIs (AFNI and SUMA) **while running**
-- the real-time image feed, InstaCorr seed-to-map updates, and GroupInCorr
group correlation all send structured data over a socket as the user clicks.
The common substrate for all of this is **NIML**.

NIML is AFNI's data-interchange layer -- think "AFNI's XML plus a binary wire
format."  It defines self-describing data *elements* and *groups*, and a
*stream* abstraction that carries them over sockets, shared memory, files, or
strings with the same API.  A surprising amount of AFNI is NIML underneath:
``.niml.dset`` files, surface datasets (:ref:`wp_surfaces`), the ``+orig``
header attributes, and every GUI-to-engine conversation.

The NIML data model
===================

``NI_element`` -- a table of typed columns
------------------------------------------

An ``NI_element`` (in ``niml/niml.h``) is a named object holding some
attributes (name = value pairs) and some data columns ("vectors").  All
columns share the same length; each has its own type.

.. code-block:: c

   typedef struct {
      int    type ;        /* NI_ELEMENT_TYPE */
      char  *name ;        /* element name, e.g. "3dGroupInCorr" */
      int    attr_num ;    /* number of attributes */
      char **attr_lhs, **attr_rhs ;   /* attribute name / value strings */
      int    vec_num ;     /* number of data columns */
      int    vec_len ;     /* length of each column (number of rows) */
      int   *vec_typ ;     /* type code of each column (NI_FLOAT, NI_INT, ...) */
      void **vec ;         /* the column data pointers */
      ...
   } NI_element ;

Build one by naming it and declaring the row count, then adding columns:

.. code-block:: c

   NI_element *nel = NI_new_data_element( "my_table", nrows ) ;
   NI_add_column( nel, NI_FLOAT, xvals ) ;      /* column 0 */
   NI_add_column( nel, NI_FLOAT, yvals ) ;      /* column 1 */
   NI_set_column_label( nel, 0, "x" ) ;
   NI_set_attribute( nel, "source", "3dProgName" ) ;

Column type codes are ``NI_BYTE``, ``NI_SHORT``, ``NI_INT``, ``NI_FLOAT``,
``NI_DOUBLE``, ``NI_COMPLEX``, ``NI_RGB``, ``NI_STRING`` (and a "rowtype"
mechanism for structs).  Read values back with ``NI_extract_float_value(nel,
row, col)`` and friends, or index ``nel->vec[col]`` directly after casting.
Free with ``NI_free_element(nel)``.

``NI_group`` -- a bag of elements
---------------------------------

An ``NI_group`` collects elements (and nested groups) plus its own
attributes -- exactly how a dataset header (many attribute elements) or a
surface ``SUMA_DSET`` (data element + node-index element) is represented.

.. code-block:: c

   NI_group *grp = NI_new_group_element() ;
   NI_set_attribute( grp, "self_prefix", "thing" ) ;
   NI_add_to_group( grp, nel ) ;         /* add an element (or another group) */

Streams: the same API over any transport
=========================================

An ``NI_stream`` is opened from a name string that encodes the transport, so
the *same* read/write code works whether you are talking to a socket or a
file:

============================  ===================================================
Stream name                   Transport
============================  ===================================================
``"tcp:host:port"``           TCP socket (2-way); one end opens ``"w"``, one ``"r"``
``"shm:key:size1+size2"``     shared memory (2-way, same machine, fast)
``"file:path"``               a file (1-way)
``"str:"``                    an in-memory string buffer (great for testing)
``"fd:0"`` / ``"fd:1"``       an existing file descriptor (stdin/stdout)
============================  ===================================================

.. code-block:: c

   NI_stream ns = NI_stream_open( "tcp:localhost:53212", "w" ) ;
   /* a socket connect is not instantaneous -- wait for it to be good: */
   if( NI_stream_goodcheck(ns, 5000) < 1 )     /* up to 5000 ms */
      ERROR_exit("could not connect") ;

   NI_write_element( ns, nel, NI_BINARY_MODE ) ;   /* or NI_TEXT_MODE */
   ...
   NI_stream_close(ns) ;

On the receiving side:

.. code-block:: c

   NI_stream ns = NI_stream_open( "tcp:*:53212", "r" ) ;  /* listen */
   while( NI_stream_goodcheck(ns,100) < 1 ) { /* wait for a connection */ }
   void *nini = NI_read_element( ns, 1000 ) ;             /* blocks up to 1000 ms */
   int typ = NI_element_type(nini) ;   /* NI_ELEMENT_TYPE or NI_GROUP_TYPE */

``NI_write_element`` serializes in text or binary; ``NI_read_element`` returns
whatever comes next (element or group -- check ``NI_element_type``).  For a
whole file at once there are ``NI_read_element_fromfile`` and
``NI_read_element_fromstring``.  Programs that speak NIML over sockets include
``3dGroupInCorr``, ``3dAFNItoNIML``, ``im2niml``, and the AFNI GUI's
``afni_niml.c``.

Talking to the AFNI/SUMA GUIs
=============================

Plugouts and the ``-niml`` port
-------------------------------

AFNI can be driven from an external process ("plugout").  Start the GUI with
``afni -niml`` (or ``-yesplugouts``) and it listens on well-known ports
obtained through ``get_port_named(...)`` -- e.g.
``get_port_named("AFNI_PLUGOUT_TCP_0")``.  Your process opens a matching
``tcp:`` stream and sends NIML command elements.  The shipped plugout programs
are the templates to copy:

* :file:`src/plugout_drive.c` -- send **driver commands** (open a window, jump
  to an xyz, set a threshold, take a snapshot).  This is the C sibling of the
  ``plugout_drive`` / ``DriveAFNI`` command line and of ``DriveSuma``.
* :file:`src/plugout_ijk.c`, :file:`src/plugout_tt.c` -- exchange the current
  crosshair voxel with AFNI.
* :file:`src/plugout_surf.c` -- surface node exchange.

The real-time plugin
--------------------

For streaming volumes into AFNI as they are acquired (from a scanner or a
simulator), the receiver is :file:`src/plug_realtime.c` and a minimal sender
is :file:`src/realtime_callback_example.c`.  The wire format is again NIML: a
control element describes the image geometry, then image data is pushed brick
by brick.  ``README.3dsvm.realtime`` and the real-time example are the places
to start.

InstaCorr: live seed-based correlation
======================================

InstaCorr computes a whole-brain correlation map from a seed voxel *the
instant you click*.  The engine is :file:`src/thd_instacorr.c` and it is a good
study in "prepare once, query many times":

* ``THD_instacorr_prepare(ICOR_setup *iset)`` does the expensive one-time
  work -- it extracts every in-mask voxel time series into an ``MRI_vectim``
  (via ``THD_dset_to_vectim_stend``), detrends, band-passes, blurs, and
  normalizes them so that a later correlation is just a dot product.
* ``THD_instacorr(ICOR_setup *iset, int ijk)`` is the fast per-click call: it
  grabs the seed time series for voxel ``ijk`` and returns an ``MRI_IMAGE`` of
  correlations against all the prepared voxels.

The GUI side (``afni_pplug_instacorr.c``) wires a click to that call and
displays the result.  The design pattern -- convert once to a normalized
time-first ``MRI_vectim``, then answer each query with a dot product -- recurs
throughout AFNI's correlation tools; see :ref:`wp_cookbook` for the ``vectim``
and correlation primitives it is built on.

GroupInCorr: correlation across a group, over a socket
======================================================

GroupInCorr extends the same idea across a **group** of subjects and splits it
across two processes that talk NIML:

* :file:`src/3dGroupInCorr.c` is the compute engine.  It loads the
  pre-processed per-subject data (prepared by ``3dSetupGroupInCorr`` into a
  ``.grpincorr.niml`` header plus a big ``.data`` file) and then **listens on a
  socket** for seed commands.
* The AFNI or SUMA GUI is the other end.  You start ``afni -niml``; when the
  user picks a seed, the GUI sends the seed voxel/node to ``3dGroupInCorr``,
  which correlates every subject, runs the group statistic (t-test, etc.), and
  sends a result dataset back for display.

The connection is a NIML ``tcp:`` stream (SUMA's default port is
``SUMA_GICORR_PORT`` = 53224, resolved via
``get_port_named("SUMA_GroupInCorr_NIML")``).  The messages themselves are
NIML elements: the setup element is named ``"3dGroupInCorr"``; status/error
messages travel as ``"3dGroupInCorr_message"`` elements.  Reading
``3dGroupInCorr.c`` end-to-end is the best single tour of "AFNI program as a
live NIML server" -- it shows the listen loop, the element protocol, the
per-seed compute, and the send-back.

.. note::

   For most new programs you will not implement a socket server -- you will
   *use* NIML to read/write ``.niml`` files and surface datasets.  But knowing
   that the same ``NI_element`` / ``NI_stream`` API scales all the way up to
   the live GUI protocols means you rarely need a second serialization
   mechanism.
