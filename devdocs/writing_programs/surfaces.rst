.. _wp_surfaces:

===================================
Surfaces
===================================

.. contents:: In this chapter
   :local:

Volumes are the ``THD`` world; surfaces are the **SUMA** world.  If your
program touches cortical surface meshes or surface-based data (one value per
node instead of one value per voxel), you work with SUMA's structures and
functions rather than ``THD_3dim_dataset``.  The two worlds share the same
NIML I/O layer underneath (see :ref:`wp_communication`), which is why surface
datasets and volume attributes feel similar.

To pull the surface API in, include the SUMA umbrella header:

.. code-block:: c

   #include "SUMA_suma.h"    /* brings in SUMA_define.h, surface + dset API */

Two things you will handle: the **geometry** (a mesh: nodes and triangles),
which is a ``SUMA_SurfaceObject``, and the **data on that geometry** (values
per node), which is a ``SUMA_DSET``.

The surface geometry: ``SUMA_SurfaceObject``
============================================

A ``SUMA_SurfaceObject`` (declared in ``SUMA/SUMA_define.h``, universally
abbreviated ``SO`` in the code) describes one mesh.  The fields you use most:

.. code-block:: c

   typedef struct {
      char  *idcode_str ;   /* unique id of this surface */
      char  *Label ;        /* human label */

      int    N_Node ;       /* number of nodes (vertices) */
      int    NodeDim ;      /* coords per node (3 for 3D) */
      float *NodeList ;     /* N_Node x NodeDim, XYZ packed row-major */

      int    N_FaceSet ;    /* number of polygons (triangles) */
      int    FaceSetDim ;   /* sides per polygon (3 for triangles) */
      int   *FaceSetList ;  /* N_FaceSet x FaceSetDim node indices */

      float *NodeNormList ; /* N_Node x 3 node normals */
      float *FaceNormList ; /* N_FaceSet x 3 face normals */
      ...
   } SUMA_SurfaceObject ;

So node ``n``'s coordinates are ``NodeList[3*n+0 .. 3*n+2]``, and triangle
``f`` connects nodes ``FaceSetList[3*f+0 .. 3*f+2]``.  Node **indices** are the
common currency between geometry and data: a surface dataset stores values
addressed by node index, exactly as a volume dataset stores values addressed
by voxel index.

Reading a surface
-----------------

SUMA reads many mesh formats -- FreeSurfer (``.asc``, ``.gii``, binary),
GIFTI, SureFit/Caret, Ply, BrainVoyager, 1D -- through one loader.  The
convenient wrapper is:

.. code-block:: c

   SUMA_SurfaceObject *SO =
      SUMA_Load_Surface_Object_Wrapper(
         if_name, NULL,       /* geometry file (and 2nd file for 2-file formats) */
         vp_name,             /* volume parent for alignment (may be NULL)       */
         SO_FT,               /* file type, e.g. SUMA_FREE_SURFER, SUMA_GIFTI    */
         SO_FF,               /* file format, e.g. SUMA_ASCII, SUMA_BINARY       */
         sv_name, 0 ) ;       /* surface-volume name; debug flag                 */

For formats that use separate coordinate and topology files (SureFit, older
FreeSurfer) you pass both ``if_name`` and ``if_name2``.  ``SO_FT`` /``SO_FF``
come from the ``SUMA_SO_File_Type`` / ``SUMA_SO_File_Format`` enums; passing
``SUMA_FT_NOT_SPECIFIED`` lets SUMA guess from the extension.  Free it with
``SUMA_Free_Surface_Object(SO)``.

The **volume parent** (``vp_name`` / ``sv_name``, a ``THD_3dim_dataset``) is
how a surface is aligned into the same RAI-DICOM space as your volumes.  This
is the bridge that lets programs like ``3dVol2Surf`` and ``3dSurf2Vol`` map
between voxel and node.

The surface data: ``SUMA_DSET``
===============================

Values living on a surface (a curvature map, a beta map, a t-stat per node)
are a ``SUMA_DSET``.  Structurally, a ``SUMA_DSET`` is a **NIML group**:

.. code-block:: c

   typedef struct {
      NI_group   *ngr ;   /* the container: header attrs + data element(s) */
      NI_element *inel ;  /* the data element (the actual columns of values) */
      NI_element *pinel ; /* the node-index element */
      ...
   } SUMA_DSET ;

That is the key mental model: **a surface dataset is a NIML group**, so
everything in :ref:`wp_communication` about ``NI_element`` columns and
attributes applies directly.  Each data column is one sub-brick's worth of
values; a companion node-index column says which node each row belongs to
(surfaces are often "sparse" -- not every node is present).

Reading and writing surface datasets
------------------------------------

.. code-block:: c

   SUMA_DSET_FORMAT form = SUMA_NO_DSET_FORMAT ;   /* auto-detect */
   SUMA_DSET *dset = SUMA_LoadDset_ns( fname, &form, 0 ) ;   /* 0 = quiet */
   ...
   SUMA_WriteDset_ns( out_prefix, dset, form, 1, 1 ) ;

The ``_ns`` ("no signal") suffix denotes the variants that do not install
SUMA's error signal handler -- the right choice for a standalone command-line
tool.  Formats (``SUMA_DSET_FORMAT``) include NIML ASCII/binary, GIFTI, and
1D.  Getting the node-index column is common enough to have helpers:

.. code-block:: c

   int *nodedef = SUMA_GetNodeDef(dset) ;      /* array of node indices */
   int  icol    = SUMA_GetNodeDefColIndex(dset) ;

Because the underlying storage is a ``NI_element``, you extract and add columns
with the same NIML calls used everywhere else (``NI_add_column``,
``SUMA_AddDsetNelCol``, ``NI_extract_float_value``, ...).

A small, complete surface program
---------------------------------

AFNI has no direct surface counterpart to :file:`src/3dToyProg.c`.  The
closest shipped code examples are :file:`src/SUMA/SUMA_TestDsetIO.c` (dataset
construction and I/O) and :file:`src/SUMA/SUMA_SurfMeasures.c` (mesh-based
calculation).  They are useful references, but neither is a small tutorial
program.

The following ``SurfToyProg`` is the surface equivalent in scope: it reads a
mesh, computes each node's distance from the origin, and writes those values
as a NIML surface dataset.  Save it as ``SurfToyProg.c`` in the AFNI ``src``
tree, add a normal SUMA-program build target, and run it as::

   SurfToyProg -i lh.pial.gii -prefix node_radius

It produces ``node_radius.niml.dset``.  The output is attached to the input
surface's domain ID, so SUMA can load it onto that same mesh.

.. code-block:: c

   #include "mrilib.h"
   #include "SUMA_suma.h"

   int main( int argc , char *argv[] )
   {
      static char FuncName[] = { "SurfToyProg" };
      char *surfname=NULL, *prefix="node_radius", *outname=NULL;
      SUMA_SurfaceObject *SO=NULL;
      SUMA_DSET *out=NULL;
      int *node=NULL, n, i, iarg=1;
      float *radius=NULL, x, y, z;

      SUMA_STANDALONE_INIT;
      SUMA_mainENTRY;

      while( iarg < argc ) {
         if( strcmp(argv[iarg],"-i") == 0 ) {
            if( ++iarg >= argc ) ERROR_exit("Need a surface after -i") ;
            surfname = argv[iarg++] ; continue ;
         }
         if( strcmp(argv[iarg],"-prefix") == 0 ) {
            if( ++iarg >= argc ) ERROR_exit("Need a name after -prefix") ;
            prefix = argv[iarg++] ; continue ;
         }
         ERROR_exit("Unknown option: %s",argv[iarg]) ;
      }
      if( surfname == NULL ) ERROR_exit("Use: SurfToyProg -i SURFACE [-prefix OUT]") ;

      SO = SUMA_Load_Surface_Object_Wrapper(
         surfname, NULL, NULL, SUMA_FT_NOT_SPECIFIED,
         SUMA_FF_NOT_SPECIFIED, NULL, 0 ) ;
      if( SO == NULL ) ERROR_exit("Cannot read surface %s",surfname) ;

      n = SO->N_Node ;
      node   = (int   *)SUMA_malloc(n*sizeof(*node)) ;
      radius = (float *)SUMA_malloc(n*sizeof(*radius)) ;
      for( i=0 ; i < n ; i++ ) {
         node[i] = i ;                         /* dense: one row per node */
         x = SO->NodeList[3*i] ;
         y = SO->NodeList[3*i+1] ;
         z = SO->NodeList[3*i+2] ;
         radius[i] = sqrtf(x*x + y*y + z*z) ;
      }

      out = SUMA_CreateDsetPointer(prefix, SUMA_NODE_BUCKET,
                                    NULL, SO->idcode_str, n) ;
      if( out == NULL ) ERROR_exit("Cannot create output dataset") ;
      if( !SUMA_AddDsetNelCol(out,"Node Index",SUMA_NODE_INDEX,node,NULL,1) ||
          !SUMA_AddDsetNelCol(out,"Radius",SUMA_NODE_FLOAT,radius,NULL,1) )
         ERROR_exit("Cannot add output columns") ;
      if( !SUMA_AddNgrHist(out->ngr,"SurfToyProg",argc,argv) )
         ERROR_exit("Cannot record output history") ;

      outname = SUMA_WriteDset_ns(prefix,out,SUMA_ASCII_NIML,1,1) ;
      if( outname == NULL ) ERROR_exit("Cannot write %s",prefix) ;
      INFO_message("Wrote %s",outname) ;

      SUMA_free(outname);
      SUMA_FreeDset(out);
      SUMA_Free_Surface_Object(SO);
      SUMA_free(node); SUMA_free(radius);
      return 0;
   }

This is deliberately much smaller than ``3dToyProg``: a surface program does
not need to construct a grid, define voxel geometry, or manage sub-bricks.
Its equivalent essentials are loading the mesh, preserving its domain ID,
providing the node-index column, and adding one or more data columns.

It is not necessary to add ``SurfToyProg`` to the distributed AFNI binaries.
The existing programs already cover the production use cases, and a second
toy executable would add a build and maintenance obligation.  It *is* useful
as a documented reference here, where it gives a new SUMA developer one
complete path from mesh to output dataset.

How this fits together
======================

A typical surface program:

#. loads the mesh with ``SUMA_Load_Surface_Object_Wrapper`` (for geometry --
   normals, areas, neighbor lists) **or** just loads a ``SUMA_DSET`` if it only
   needs the per-node values;
#. reads/derives per-node values into ``NI_element`` columns;
#. writes a new ``SUMA_DSET``.

Real programs to read for the full idiom: ``SurfMeasures`` and ``3dVol2Surf``
(surface geometry + volume sampling), ``ROI2dataset`` and ``ConvertDset``
(surface-dataset manipulation), and ``SurfClust`` (mesh-based clustering).
For driving the SUMA GUI itself, or streaming surface data to it live, see the
communication chapter next.

.. note::

   The SUMA library is large and its conventions (the ``SUMA_Boolean`` return
   type, ``SUMA_ENTRY``/``SUMA_RETURN``, the ``SUMAg_*`` globals for GUI state)
   differ a little from the ``THD`` side.  For a pure command-line surface
   tool you can ignore the GUI globals; you mainly need the loader, the
   ``SUMA_DSET`` I/O, and the NIML column API.
