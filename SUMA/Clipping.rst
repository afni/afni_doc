.. _suma_clipping:

************************
**SUMA Clipping Planes**
************************

.. contents:: :local:

.. highlight:: Tcsh

.. note:: To utilize this functionality, your system's AFNI version
          should be at least 21.1.13.

.. note:: *This page is a work in progress.*

Introduction
=========================

Visualizing surface data is great.  But sometimes, you might want to
focus on just part of the data, or to look at nested layers.  In these
cases (and others), it can be useful to have **clipping planes**:
these are geometrically flat planes that clip away data on one side.
At present, you can have up to 6 planes, each of which is mobile
(translate, rotate, flip, etc.).

| One particularly useful application of clipping planes is here:
| :ref:`tut_surflayers`

Clipping plane cheatsheet
=========================

Enter/exit clipping plane mode with ``Ctrl+Shift+c``.  The first time
one enters this mode, 1 clipping plane appears.  While in clipping
plane mode is active, a "C" appears in the SUMA viewer panel.

There can be up to 6 clipping planes. They are numbered [1-6], and
each has a unique color (in order):

      | 1 - Red  
      | 2 - Green 
      | 3 - Blue  
      | 4 - Cyan 
      | 5 - Magenta 
      | 6 - Yellow

Clipping planes can be scrolled (= translated) along their normals
and/or rotated around their tangent or cotangent axes, using the mouse
or keypresses.  

Below:

  *[1-6]* means one of the clipping plane numbers, in range [1, 6].

  An *active* clipping plane is clipping (whether visible or not),
  while an *inactive* plane is not clipping (whether visible or
  not).

  A *selected* plane can be controlled with the action keys
  (scroll/translate, rotate, flip/invert, etc.).

  The *normal* of a plane is a direction perpendicular its
  face. Scrolling/translation is motion along either the "inner" or
  "outer" normal direction.  The "outer" normal is side of the plane
  that is originally clipping.

  The *rotation* of a plane moves it around one of the coordinate
  axes.  Each plane can rotate around two axes. If the plane's normal
  is originally parallel to the y-axis, then it can rotate around
  either the x- or z-axis.

  On a Mac, you would likely replace the ``Alt`` keystroke with
  ``Cmd`` or ``Opt``.

.. list-table:: 
   :header-rows: 1
   :align: center
   :widths: 25 85

   * - Key/mouse
     - Functionality
   * - **Ctrl+Shift+c**
     - Toggle in and out of clipping plane mode
   * - **[1-6]**
     - Toggle the numbered clipping plane on/off
   * - **7**
     - Toggle all active clipping planes on or off
   * - **0**
     - Reset all clipping planes (to basic starting state)
   * - **n**
     - Successively add a new clipping plane (up to number 6)
   * - **Ctrl+f**
     - Flip/invert the clipping direction of selected plane
   * - **Shift+c**
     - Toggle view of all active clipping planes on/off (active
       clipping remain active)
   * - **Alt+[1-6]**
     - Select a clipping plane, after which it can be flipped,
       rotated, scrolled/translated, etc.
   * - **Alt+[up/down arrow]**
     - Rotate a selected clipping plane around one axis (perpendicular
       to its normal)
   * - **Alt+[left/right arrow]**
     - Rotate a selected clipping plane around another axis
       (perpendicular to its normal)
   * - **Alt+[scroll wheel]**
     - Translate a selected clipping plane along its normal 
   * - **s**
     - Scroll/translate a selected clipping plane "inwards"
   * - **Shift+s**
     - Scroll/translate a selected clipping plane "outwards"
   * - **+**            
     - Double the current scroll/rotation stepsize; can be used
       repeatedly to increase further.
   * - **-**
     - Halve the current scroll/rotation stepsize; can be used
       repeatedly to decrease further.
   * - **=**
     - Reset the current scroll/rotation stepsize (current defaults: 1
       mm scroll, 1 deg rotation).

|

.. comment


    .. list-table:: 
       :header-rows: 1
       :align: center
       :widths: 20 80

       * - Key/mouse
         - Functionality
       * - ``Ctrl+Shift+c``
         - Toggle in and out of clipping plane mode
       * - ``[1-6]``
         - Toggle the numbered clipping plane on/off
       * - ``7``
         - Toggle all active clipping planes on or off
       * - ``0``
         - Reset all clipping planes (to basic starting state)
       * - ``n``
         - Successively add a new clipping plane (up to number 6)
       * - ``Ctrl-f``
         - Flip the clipping direction of selected plane
       * - ``Shift+c``
         - Toggle view of all active clipping planes on/off (active
           clipping remain active)
       * - ``Alt/Cmd/Opt-[1-6]``
         - Select a clipping plane, after which it can be flipped,
           rotated, scrolled/translated, etc.
       * - ``Alt/Cmd/Opt+[scroll wheel]``
         - Translate a clipping plane along the normal (i.e.,
           perpendicular to plane face)
       * - ``s``
         - Scroll clipping plane "inwards"
       * - ``Shift-s``
         - Scroll clipping plane "outwards"
       * - ``Alt/Cmd/Opt+[up/down arrow]``
         - Rotate clipping plane around one axis
       * - ``Alt/Cmd/Opt+[left/right arrow]``
         - Rotate clipping plane around its another axis
       * - ``+``            
         - Double the current scroll/rotation stepsize; can be used
           repeatedly to increase further.
       * - ``-``
         - Halve the current scroll/rotation stepsize; can be used
           repeatedly to decrease further.
       * - ``=``
         - Reset the current scroll/rotation stepsize (current defaults: 1
           mm scroll, 1 deg rotation).


   
