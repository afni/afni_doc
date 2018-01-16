**********
SurfToSurf
**********

.. _SurfToSurf:

.. contents:: 
    :depth: 4 

.. code-block:: none

    
    Usage: SurfToSurf <-i_TYPE S1> [<-sv SV1>]
                      <-i_TYPE S2> [<-sv SV1>]
                      [<-prefix PREFIX>]
                      [<-output_params PARAM_LIST>]
                      [<-node_indices NODE_INDICES>]
                      [<-proj_dir PROJ_DIR>]
                      [<-data DATA>]
                      [<-node_debug NODE>]
                      [<-debug DBG_LEVEL>]
                      [-make_consistent]
                      [<-dset DSET>]
                      [<-mapfile MAP_INFO>]
     
      This program is used to interpolate data from one surface (S2)
     to another (S1), assuming the surfaces are quite similar in
     shape but having different meshes (non-isotopic).
     This is done by projecting each node (nj) of S1 along the normal
     at nj and finding the closest triangle t of S2 that is intersected
     by this projection. Projection is actually bidirectional.
     If such a triangle t is found, the nodes (of S2) forming it are 
     considered to be the neighbors of nj.
     Values (arbitrary data, or coordinates) at these neighboring nodes
     are then transfered to nj using barycentric interpolation or 
     nearest-node interpolation.
     Nodes whose projections fail to intersect triangles in S2 are given
     nonsensical values of -1 and 0.0 in the output.
    
     Mandatory input:
      Two surfaces are required at input. See -i_TYPE options
      below for more information. 
    
     Optional input:
      -prefix PREFIX: Specify the prefix of the output file.
                      The output file is in 1D format at the moment.
                      Default is SurfToSurf
      -output_params PARAM_LIST: Specify the list of mapping
                                 parameters to include in output
         PARAM_LIST can have any or all of the following:
            NearestTriangleNodes: Use Barycentric interpolation (default)
                                  and output indices of 3 nodes from S2
                                  that neighbor nj of S1
            NearestNode: Use only the closest node from S2 (of the three 
                         closest neighbors) to nj of S1 for interpolation
                         and output the index of that closest node.
            NearestTriangle: Output index of triangle t from S2 that
                             is the closest to nj along its projection
                             direction. 
            DistanceToSurf: Output distance (signed) from nj, along 
                            projection direction to S2.
                            This is the parameter output by the precursor
                            program CompareSurfaces
            ProjectionOnSurf: Output coordinates of projection of nj onto 
                              triangle t of S2.
            NearestNodeCoords: X Y Z coordinates of closest node on S2
            Data: Output the data from S2, interpolated onto S1
                  If no data is specified via the -data option, then
                  the XYZ coordinates of SO2's nodes are considered
                  the data.
      -data DATA: 1D file containing data to be interpolated.
                  Each row i contains data for node i of S2.
                  You must have one row for each node making up S2.
                  In other terms, if S2 has N nodes, you need N rows
                  in DATA. 
                  Each column of DATA is processed separately (think
                  sub-bricks, and spatial interpolation).
                  You can use [] selectors to choose a subset 
                  of columns.
                  If -data option is not specified and Data is in PARAM_LIST
                  then the XYZ coordinates of SO2's nodes are the data.
      -dset DSET: Treat like -data, but works best with datasets, preserving
                  header information in the output.
                  -dset and -data are mutually exclusive.
                  Also, -dset and parameter Data cannot be mixed.
      -node_indices NODE_INDICES: 1D file containing the indices of S1
                                  to consider. The default is all of the
                                  nodes in S1. Only one column of values is
                                  allowed here, use [] selectors to choose
                                  the column of node indices if NODE_INDICES
                                  has multiple columns in it.
      -proj_dir PROJ_DIR: 1D file containing projection directions to use
                          instead of the node normals of S1.
                          Each row should contain one direction for each
                          of the nodes forming S1.
      -closest_possible OO: Flag allowing the substitution of the projection
                            result with the closest node that could be found
                            along any direction.
                            0: Don't do that, direction results only.
                            1: Use closest node if projection fails to hit target
                            2: Use closest node if it is at a closer distance.
                            3: Use closest and don't bother with projections.
      -make_consistent: Force a consistency check and correct triangle 
                        orientation of S1 if needed. Triangles are also
                        oriented such that the majority of normals point
                        away from center of surface.
                        The program might not succeed in repairing some
                        meshes with inconsistent orientation.
      -mapfile MAP_INFO: Use the mapping from S2 to S1 that is stored in
                         MAP_INFO. MAP_INFO is a file containing the mapping
                         parameters between surfaces S2 and S1. 
                         It is generated automatically by SurfToSurf when 
                         -mapfile is not used, and saved under PREFIX.niml.M2M.
                         Reusing the MAP_INFO file allows for faster execution
                         of SurfToSurf the next time around, assuming of course
                         that the two surfaces involved are the same, and that 
                         only the input data differs.
                   MAP_INFO is also generated by MapIcosahedron.
    
     Specifying input surfaces using -i or -i_TYPE options: 
        -i_TYPE inSurf specifies the input surface,
                TYPE is one of the following:
           fs: FreeSurfer surface. 
               If surface name has .asc it is assumed to be
               in ASCII format. Otherwise it is assumed to be
               in BINARY_BE (Big Endian) format.
               Patches in Binary format cannot be read at the moment.
           sf: SureFit surface. 
               You must specify the .coord followed by the .topo file.
           vec (or 1D): Simple ascii matrix format. 
                You must specify the coord (NodeList) file followed by 
                the topo (FaceSetList) file.
                coord contains 3 floats per line, representing 
                X Y Z vertex coordinates.
                topo contains 3 ints per line, representing 
                v1 v2 v3 triangle vertices.
           ply: PLY format, ascii or binary.
                Only vertex and triangulation info is preserved.
           stl: STL format, ascii or binary.
                This format of no use for much of the surface-based
                analyses. Objects are defined as a soup of triangles
                with no information about which edges they share. STL is only
                useful for taking surface models to some 3D printing 
                software.
           mni: MNI .obj format, ascii only.
                Only vertex, triangulation, and node normals info is preserved.
           byu: BYU format, ascii.
                Polygons with more than 3 edges are turned into
                triangles.
           bv: BrainVoyager format. 
               Only vertex and triangulation info is preserved.
           dx: OpenDX ascii mesh format.
               Only vertex and triangulation info is preserved.
               Requires presence of 3 objects, the one of class 
               'field' should contain 2 components 'positions'
               and 'connections' that point to the two objects
               containing node coordinates and topology, respectively.
           gii: GIFTI XML surface format.
           obj: OBJ file format for triangular meshes only. The following
                primitives are preserved: v (vertices),  (faces, triangles
                only), and p (points)
     Note that if the surface filename has the proper extension, 
     it is enough to use the -i option and let the programs guess
     the type from the extension.
    
     You can also specify multiple surfaces after -i option. This makes
     it possible to use wildcards on the command line for reading in a bunch
     of surfaces at once.
    
         -onestate: Make all -i_* surfaces have the same state, i.e.
                    they all appear at the same time in the viewer.
                    By default, each -i_* surface has its own state. 
                    For -onestate to take effect, it must precede all -i
                    options with on the command line. 
         -anatomical: Label all -i surfaces as anatomically correct.
                    Again, this option should precede the -i_* options.
    
     More variants for option -i:
    -----------------------------
     You can also load standard-mesh spheres that are formed in memory
     with the following notation
         -i ldNUM:  Where NUM is the parameter controlling
                    the mesh density exactly as the parameter -ld linDepth
                    does in CreateIcosahedron. For example: 
                        suma -i ld60
                    create on the fly a surface that is identical to the
                    one produced by: CreateIcosahedron -ld 60 -tosphere
         -i rdNUM: Same as -i ldNUM but with NUM specifying the equivalent
                   of parameter -rd recDepth in CreateIcosahedron.
    
     To keep the option confusing enough, you can also use -i to load
     template surfaces. For example:
               suma -i lh:MNI_N27:ld60:smoothwm 
     will load the left hemisphere smoothwm surface for template MNI_N27 
     at standard mesh density ld60.
     The string following -i is formatted thusly:
         HEMI:TEMPLATE:DENSITY:SURF where:
         HEMI specifies a hemisphere. Choose from 'l', 'r', 'lh' or 'rh'.
              You must specify a hemisphere with option -i because it is 
              supposed to load one surface at a time. 
              You can load multiple surfaces with -spec which also supports 
              these features.
         TEMPLATE: Specify the template name. For now, choose from MNI_N27 if
                   you want to use the FreeSurfer reconstructed surfaces from
                   the MNI_N27 volume, or TT_N27
                   Those templates must be installed under this directory:
                     /Users/discoraj/.afni/data/
                   If you have no surface templates there, download
                     http:afni.nimh.nih.gov:/pub/dist/tgz/suma_MNI_N27.tgz
                   and/or
                     http:afni.nimh.nih.gov:/pub/dist/tgz/suma_TT_N27.tgz
                   and untar them under directory /Users/discoraj/.afni/data/
         DENSITY: Use if you want to load standard-mesh versions of the template
                  surfaces. Note that only ld20, ld60, ld120, and ld141 are in
                  the current distributed templates. You can create other 
                  densities if you wish with MapIcosahedron, but follow the
                  same naming convention to enable SUMA to find them.
         SURF: Which surface do you want. The string matching is partial, as long
               as the match is unique. 
               So for example something like: suma -i l:MNI_N27:ld60:smooth
               is more than enough to get you the ld60 MNI_N27 left hemisphere
               smoothwm surface.
         The order in which you specify HEMI, TEMPLATE, DENSITY, and SURF, does
         not matter.
         For template surfaces, the -sv option is provided automatically, so you
         can have SUMA talking to AFNI with something like:
                 suma -i l:MNI_N27:ld60:smooth &
                 afni -niml /Users/discoraj/.afni/data/suma_MNI_N27 
    
     Specifying surfaces using -t* options: 
       -tn TYPE NAME: specify surface type and name.
                      See below for help on the parameters.
       -tsn TYPE STATE NAME: specify surface type state and name.
            TYPE: Choose from the following (case sensitive):
               1D: 1D format
               FS: FreeSurfer ascii format
               PLY: ply format
               MNI: MNI obj ascii format
               BYU: byu format
               SF: Caret/SureFit format
               BV: BrainVoyager format
               GII: GIFTI format
            NAME: Name of surface file. 
               For SF and 1D formats, NAME is composed of two names
               the coord file followed by the topo file
            STATE: State of the surface.
               Default is S1, S2.... for each surface.
     Specifying a Surface Volume:
        -sv SurfaceVolume [VolParam for sf surfaces]
           If you supply a surface volume, the coordinates of the input surface.
            are modified to SUMA's convention and aligned with SurfaceVolume.
            You must also specify a VolParam file for SureFit surfaces.
     Specifying a surface specification (spec) file:
        -spec SPEC: specify the name of the SPEC file.
         As with option -i, you can load template
         spec files with symbolic notation trickery as in:
                        suma -spec MNI_N27 
         which will load the all the surfaces from template MNI_N27
         at the original FreeSurfer mesh density.
      The string following -spec is formatted in the following manner:
         HEMI:TEMPLATE:DENSITY where:
         HEMI specifies a hemisphere. Choose from 'l', 'r', 'lh', 'rh', 'lr', or
              'both' which is the default if you do not specify a hemisphere.
         TEMPLATE: Specify the template name. For now, choose from MNI_N27 if
                   you want surfaces from the MNI_N27 volume, or TT_N27
                   for the Talairach version.
                   Those templates must be installed under this directory:
                     /Users/discoraj/.afni/data/
                   If you have no surface templates there, download
                     http:afni.nimh.nih.gov:/pub/dist/tgz/suma_MNI_N27.tgz
                   and/or
                     http:afni.nimh.nih.gov:/pub/dist/tgz/suma_TT_N27.tgz
                   and untar them under directory /Users/discoraj/.afni/data/
         DENSITY: Use if you want to load standard-mesh versions of the template
                  surfaces. Note that only ld20, ld60, ld120, and ld141 are in
                  the current distributed templates. You can create other 
                  densities if you wish with MapIcosahedron, but follow the
                  same naming convention to enable SUMA to find them.
                  This parameter is optional.
         The order in which you specify HEMI, TEMPLATE, and DENSITY, does
         not matter.
         For template surfaces, the -sv option is provided automatically, so you
         can have SUMA talking to AFNI with something like:
                 suma -spec MNI_N27:ld60 &
                 afni -niml /Users/discoraj/.afni/data/suma_MNI_N27 
    
     Specifying a surface using -surf_? method:
        -surf_A SURFACE: specify the name of the first
                surface to load. If the program requires
                or allows multiple surfaces, use -surf_B
                ... -surf_Z .
                You need not use _A if only one surface is
                expected.
                SURFACE is the name of the surface as specified
                in the SPEC file. The use of -surf_ option 
                requires the use of -spec option.
     Specifying output surfaces using -o or -o_TYPE options: 
        -o_TYPE outSurf specifies the output surface, 
                TYPE is one of the following:
           fs: FreeSurfer ascii surface. 
           fsp: FeeSurfer ascii patch surface. 
                In addition to outSurf, you need to specify
                the name of the parent surface for the patch.
                using the -ipar_TYPE option.
                This option is only for ConvertSurface 
           sf: SureFit surface. 
               For most programs, you are expected to specify prefix:
               i.e. -o_sf brain. In some programs, you are allowed to 
               specify both .coord and .topo file names: 
               i.e. -o_sf XYZ.coord TRI.topo
               The program will determine your choice by examining 
               the first character of the second parameter following
               -o_sf. If that character is a '-' then you have supplied
               a prefix and the program will generate the coord and topo names.
           vec (or 1D): Simple ascii matrix format. 
                For most programs, you are expected to specify prefix:
                i.e. -o_1D brain. In some programs, you are allowed to 
                specify both coord and topo file names: 
                i.e. -o_1D brain.1D.coord brain.1D.topo
                coord contains 3 floats per line, representing 
                X Y Z vertex coordinates.
                topo contains 3 ints per line, representing 
                v1 v2 v3 triangle vertices.
           ply: PLY format, ascii or binary.
           stl: STL format, ascii or binary (see also STL under option -i_TYPE).
           byu: BYU format, ascii or binary.
           mni: MNI obj format, ascii only.
           gii: GIFTI format, ascii.
                You can also enforce the encoding of data arrays
                by using gii_asc, gii_b64, or gii_b64gz for 
                ASCII, Base64, or Base64 Gzipped. 
                If AFNI_NIML_TEXT_DATA environment variable is set to YES, the
                the default encoding is ASCII, otherwise it is Base64.
           obj: No support for writing OBJ format exists yet.
     Note that if the surface filename has the proper extension, 
     it is enough to use the -o option and let the programs guess
     the type from the extension.
       [-novolreg]: Ignore any Rotate, Volreg, Tagalign, 
                    or WarpDrive transformations present in 
                    the Surface Volume.
       [-noxform]: Same as -novolreg
       [-setenv "'ENVname=ENVvalue'"]: Set environment variable ENVname
                    to be ENVvalue. Quotes are necessary.
                 Example: suma -setenv "'SUMA_BackgroundColor = 1 0 1'"
                    See also options -update_env, -environment, etc
                    in the output of 'suma -help'
      Common Debugging Options:
       [-trace]: Turns on In/Out debug and Memory tracing.
                 For speeding up the tracing log, I recommend 
                 you redirect stdout to a file when using this option.
                 For example, if you were running suma you would use:
                 suma -spec lh.spec -sv ... > TraceFile
                 This option replaces the old -iodbg and -memdbg.
       [-TRACE]: Turns on extreme tracing.
       [-nomall]: Turn off memory tracing.
       [-yesmall]: Turn on memory tracing (default).
      NOTE: For programs that output results to stdout
        (that is to your shell/screen), the debugging info
        might get mixed up with your results.
    
    
    Global Options (available to all AFNI/SUMA programs)
      -h: Mini help, at time, same as -help in many cases.
      -help: The entire help output
      -HELP: Extreme help, same as -help in majority of cases.
      -h_view: Open help in text editor. AFNI will try to find a GUI editor
      -hview : on your machine. You can control which it should use by
               setting environment variable AFNI_GUI_EDITOR.
      -h_web: Open help in web browser. AFNI will try to find a browser.
      -hweb : on your machine. You can control which it should use by
              setting environment variable AFNI_GUI_EDITOR. 
      -h_find WORD: Look for lines in this programs's -help output that match
                    (approximately) WORD.
      -h_raw: Help string unedited
      -h_spx: Help string in sphinx loveliness, but do not try to autoformat
      -h_aspx: Help string in sphinx with autoformatting of options, etc.
      -all_opts: Try to identify all options for the program from the
                 output of its -help option. Some options might be missed
                 and others misidentified. Use this output for hints only.
      
    
    
    Compile Date:
       Nov  9 2017
    
           Ziad S. Saad SSCC/NIMH/NIH saadz@mail.nih.gov     
