:tocdepth: 2

.. _devdocs_openp:

.. comment:

   these notes were originally poster here online:

   https://afni.nimh.nih.gov/pub/dist/doc/misc/OpenMP.html

****************************************
Elementary OpenMP in AFNI
****************************************

.. highlight:: c

.. contents:: :local:

Overview
=========

*These are notes by Bob Cox (AKA Zhark the Parallelizer) from May,
2009.*

Several programs in AFNI are written using `OpenMP
<https://www.openmp.org/>`_, which provides support for
parallelization of tasks.  Some of the programs that use OpenMP are:

.. list-table:: 
   :header-rows: 0
   :widths: 20 20 20

   * - **3dAllineate**
     - **3dAutoTcorrelate**
     - **3dBandpass**
   * - **3dBlurToFWHM**
     - **3dClustSim**
     - **3dDegreeCentrality**
   * - **3dDWUncert**
     - **3dECM**
     - **3dFWHMx**
   * - **3dGroupInCorr**
     - **3dLFCD**
     - **3dLocalACF**
   * - **3dLocalHistog**
     - **3dLocalPV**
     - **3dLocalstat**
   * - **3dMSE**
     - **3dNwarpAdjust**
     - **3dNwarpApply**
   * - **3dNwarpCalc**
     - **3dNwarpCat**
     - **3dNwarpFuncs**
   * - **3dNwarpXYZ**
     - **3dQwarp**
     - **3dREMLfit**
   * - **3dTcorr1D**
     - **3dTcorrMap**
     - **3dUnifize**
   * - **3dXClustSim**
     - **...**
     -

The above is not an exhaustive list (though *I* sure am tired of
reading it).

Note that there are some other scripts or programs in AFNI that wrap
around one or more of the above programs (e.g., ``3dQwarp`` is used
within ``auto_warp.py``, ``@SSwarper`` and ``@animal_warper``, among
others).  

Introduction
===============

In the last couple months, I have explored using the parallelization
toolkit OpenMP in AFNI. OpenMP is built in to several compilers,
including **gcc-4.2**. OpenMP comprises a set of ``#pragma``\ s,
functions, etc., that are used to control parallel threads on a
shared-memory multi-CPU system (e.g., my octo-core Mac).

| An OpenMP tutorial can be found at
| `<https://computing.llnl.gov/tutorials/openMP/>`_ 
| and the OpenMP 2.5 spec can be found at
| `<http://www.openmp.org/mp-documents/spec25.pdf>`_
| Both of these are valuable documents with sample code. Another
  interesting document is
| `<http://www.hpcwire.com/features/17884424.html>`_
| which discusses OpenMP vs. MPI and an extended version of OpenMP
  called Cluster OpenMP from Intel.

OpenMP should not be confused with Open MPI, which is a completely
different piece of software for parallelization! MPI (= Message
Passing Interface) lets you distribute work across multiple CPUs and
multiple systems by explicitly passing messages back and forth between
processes/threads. MPI is more flexible than OpenMP in that it allows
a whole network of computers to be harnessed into one job.

MPI is also harder to use than OpenMP, in that the programmer has to
manage the inter-thread data flow very explicitly. In OpenMP, the data
model is that some data is explicitly in shared memory, visible to be
read and written by each thread by normal C statements, and some data
is explictly private to each thread, and when modified in one thread
that change will not be visible to the other threads. In OpenMP, the
principal burden on the programmer is to make sure that the shared
data is written to in a coherent manner by the different threads. In
MPI, the burden on the programmer is to explicitly determine when data
held in one thread is communicated to another thread. Converting an
existing program to use OpenMP is generally much simpler than making
it work with MPI.

Memory Concepts
==================

The two most important things to realize about OpenMP's parallel model
for computation are

#. OpenMP is shared memory computing; unless you take care to make
   certain variables and arrays private to each thread, all the data
   is shared between threads.

#. You are responsible for managing the access to shared memory so
   that conflicts don't occur (e.g., two processes don't try to write
   to the same shared variable at the same time). The compiler does
   not even attempt to help you with analyzing the code to detect this
   potential problem.

   * In particular, if your parallel code is writing results into a
     shared memory array (as is almost certain to be happening so that
     you can get some results out), then you have to make sure that
     different threads won't be writing to the same elements of the
     array at the same time, where one thread potentially destroys the
     results from another thread.

   * If your parallel code is summing up some value (say), you have to
     make sure that different threads don't conflict when they modify
     this value.

   * If your parallel code is using some temporary variable or array,
     you probably want to make sure that each thread gets a separate
     copy of that object.

None of these things are hard, once you think about the concepts of
parallel access to shared memory for a while, and realize the
potential for conflicts between threads trying to update the same
location more or less at the same instant. In particular, assigning to
static variables is a real potential problem -- and this might occur
inside some function call that you haven't looked at. (*Hint:* look at
the functions you call from inside a parallelized part of your code!)

Compiling to use OpenMP
==========================

In your AFNI Makefile, you have to set the variable ``OMPFLAG`` to be
the value of the flag(s) to the compiler/linker needs for dealing with
OpenMP, plus you have to enable OpenMP inside AFNI code by setting the
C macro variable ``USE_OMP`` to be defined. For gcc-4.2, my Makefile
contains the single extra line::

  OMPFLAG = -fopenmp -DUSE_OMP

Some AFNI Makefile.*-s now contain definitions of OMPFLAG so that the
binary builds include some parallelized programs. At this moment,
these programs are:

.. list-table:: 
   :header-rows: 1
   :widths: 10 90
            
   * - Program
     - OpenMP use
   * - **3BlurInMask**
     - parallelized across sub-bricks
   * - **3dTcorrMap**
     - parallelized across the inner voxel loop
   * - **3dDespike**
     - parallelized across voxels
   * - **3dAllineate**
     - parallelized across voxels in the interpolation functions
       (Example #1 below)
   * - **AlphaSim**
     - parallelized across simulated 3D volumes
   * - **3dREMLfit**
     - parallelized across voxels in the REML estimation loop, and
       across ARMA(1,1) (a,b) parameter pairs in the REML matrix setup
       loop.
   * - **3dLocalPV**
     - parallelized across voxels
   * - **3dLocalStat**
     - parallelized across voxels
   * - **3dBandpass**
     - the ``-blur`` option is parallelized across sub-bricks
   * - **3dGroupInCorr**
     - computations of correlations are parallelized across time
       series datasets; computations of t-tests are parallelized
       across voxels
   * - **3dTcorr1D**
     - computations are parallelized across columns of the input 1D
       file
   * - **3dClustSim**
     - *(the new and improved version of ``AlphaSim``, which has been
       deprecated for a long time)* parallelized across simulated 3D
       volumes, and with fewer ``malloc``/\ ``free`` spin problems,
       since it uses a customized clustering procedure rather than the
       general one ``AlphaSim`` used; also, workspaces for each thread
       are allocated before the work begins, so that ``malloc``/\
       ``free`` invocations inside the simulation loop are limited;
       cf. Example #6 below for a discussion of why this is bad.
   * - **3dAutoTcorrelate**
     - parallelized across the outer voxel loop; to get any decent
       speedup required converting the input dataset to a 'vectim'
       struct (time order first rather than last): otherwise,
       thrashing through the input dataset time points over and over
       was grossly slow.

In each case, I chose to invoke OpenMP at the simplest place that did
a lot of work that was independent between components 
-  voxels or
sub-bricks. In the case of ``3dBlurInMask``, parallelizing across voxels
would be quite difficult, due to the structure of the algorithm 
-  but
parallelizing across sub-bricks was essentially trivial, since the
blurring algorithm is completely independent for each volume of data.


All of the above programs, except for ``3dGroupInCorr`` [Dec 2009] and
``3dClustSim`` [Jul 2010], were originally written as serial programs,
and later converted to OpenMP. Some of the problems arising in these
conversions are outlined below. It is much easier to write a program
from scratch to use OpenMP than to retrofit it later!

In AFNI's Makefile.INCLUDE, files that are to be compiled/linked with
OpenMP use ``CCOMP`` instead of ``CC`` or ``CCFAST`` for the
compilation/linking. You'll have to add an extra make rule for each
file that needs this special handling. **NB:** Any program that calls
an OpenMP-enabled function, even if the main program knows nothing
about OpenMP, must be linked with ``CCOMP`` to get the proper libraries
included.

At the top of any C source file that's going to use OpenMP
``#pragma``\ s or function calls, you should put a code block like so::

  #ifdef USE_OMP
  #include <omp.h>
  #endif

By default, OpenMP will use all CPUs available in any parallel block
of code. This behavior can be changed by setting the environment
variable ``OMP_NUM_THREADS`` to some smaller integer value. (There are
also OpenMP library functions that let you control this from within a
program, but I've not used these.)

Example #1 -- A basic case
================================

My first example is a function from ``mri_genalign_util.c``. The
function below does linear interpolation from the input image fim at
npp output points whose index coordinates are given in input arrays
``ip``, ``jp``, and ``kp``, storing the results into user-allocated
array ``vv``. (Rather than make up a trivial sample case, I'm showing
a real piece of code that's used in ``3dAllineate``.) The two OpenMP
directives are shown in the lines starting with ``#pragma omp ..``::

  #define FAR(i,j,k)  far[(i)+(j)*nx+(k)*nxy]
  #define CLIP(mm,nn) if(mm < 0)mm=0; else if(mm > nn)mm=nn

  void GA_interp_linear( MRI_IMAGE *fim ,
                         int npp, float *ip, float *jp, float *kp, float *vv )
  {
  ENTRY("GA_interp_linear") ;

  #pragma omp parallel if(npp > 9999)
   {
     int nx=fim->nx , ny=fim->ny , nz=fim->nz , nxy=nx*ny , pp ;
     float nxh=nx-0.501f , nyh=ny-0.501f , nzh=nz-0.501f , xx,yy,zz ;
     float fx,fy,fz ;
     float *far = MRI_FLOAT_PTR(fim) ;
     int nx1=nx-1,ny1=ny-1,nz1=nz-1 ;
     float ix,jy,kz ;
     int ix_00,ix_p1 ;         /* interpolation indices */
     int jy_00,jy_p1 ;
     int kz_00,kz_p1 ;
     float wt_00,wt_p1 ;       /* interpolation weights */
     float f_j00_k00, f_jp1_k00, f_j00_kp1, f_jp1_kp1, f_k00, f_kp1 ;

  #pragma omp for
     for( pp=0 ; pp < npp ; pp++ ){
       xx = ip[pp] ; if( xx < -0.499f || xx > nxh ){ vv[pp]=outval; continue; }
       yy = jp[pp] ; if( yy < -0.499f || yy > nyh ){ vv[pp]=outval; continue; }
       zz = kp[pp] ; if( zz < -0.499f || zz > nzh ){ vv[pp]=outval; continue; }

       ix = floorf(xx) ;  fx = xx - ix ;   /* integer and       */
       jy = floorf(yy) ;  fy = yy - jy ;   /* fractional coords */
       kz = floorf(zz) ;  fz = zz - kz ;

       ix_00 = ix ; ix_p1 = ix_00+1 ; CLIP(ix_00,nx1) ; CLIP(ix_p1,nx1) ;
       jy_00 = jy ; jy_p1 = jy_00+1 ; CLIP(jy_00,ny1) ; CLIP(jy_p1,ny1) ;
       kz_00 = kz ; kz_p1 = kz_00+1 ; CLIP(kz_00,nz1) ; CLIP(kz_p1,nz1) ;

       wt_00 = 1.0f-fx ; wt_p1 = fx ;  /* weights for ix_00 and ix_p1 points */

  #undef  XINT
  #define XINT(j,k) wt_00*FAR(ix_00,j,k)+wt_p1*FAR(ix_p1,j,k)

       /* interpolate to location ix+fx at each jy,kz level */

       f_j00_k00 = XINT(jy_00,kz_00) ; f_jp1_k00 = XINT(jy_p1,kz_00) ;
       f_j00_kp1 = XINT(jy_00,kz_p1) ; f_jp1_kp1 = XINT(jy_p1,kz_p1) ;

       /* interpolate to jy+fy at each kz level */

       wt_00 = 1.0f-fy ; wt_p1 = fy ;
       f_k00 =  wt_00 * f_j00_k00 + wt_p1 * f_jp1_k00 ;
       f_kp1 =  wt_00 * f_j00_kp1 + wt_p1 * f_jp1_kp1 ;

       /* interpolate to kz+fz to get output */

       vv[pp] = (1.0f-fz) * f_k00 + fz * f_kp1 ;
     }
   } /* end OpenMP */

     EXRETURN ;
  }

The directive::

  #pragma omp parallel if(npp > 9999)

is at the head of a "structured block" of code that will be executed
in parallel. (A "structured block" in OpenMP-lingo means a C {...}
block that contains no way out (e.g., no return) except to fall
through the bottom.) You should imagine that all the code inside this
block will be executed in parallel on multiple CPUs -- even code that
does exactly the same thing. To get different things done on different
CPUs, we need the second directive, that will specify the
"work-sharing".

In the above code, I've declared all the internal variables used in
the function inside the parallel block. This means that these
variables are all private to each thread. Assignments to any one of
these in one thread will have no impact on the other
threads. Declaring variables like this is the easy way to make sure
they are thread-private and won't accidentally conflict. It is also
possible to declare outside variables to be thread-private in the
parallel #pragma, but I'd rather skip that -- doing it with private
declarations, as above, is simpler to think about and to
program. Thus, for example, the pointer::

  float *far = MRI_FLOAT_PTR(fim) ;

will have N identical copies spread around amongst the N threads. This
is slightly inefficient with respect to memory usage -- since far is
never changed after the initial assignment, it could be a shared
variable declared and initialized outside the parallel block -- but
unless the amount of memory duplication is huge, the rule:

  *For most variables used and assigned to in the* ``parallel``
  *block, declare them inside the* ``parallel`` *block.*

is the simplest to code with. The only exception would be variables
whose values you wish to preserve when the ``parallel`` block ends and
normal (sequential) program execution resumes -- typically, these
variables are output arrays.

Note that the ``if(npp > 9999)`` part of the ``parallel`` directive
means that the code will actually only be parallelized if the number
of points to interpolate at one shot is 10,000 or more. There is no
point in parallelizing at too fine a level -- the thread startup and
management overhead will be too large to get any net program speedup
from the OpenMP-ization. (You might well ask where I got the number
9999 from -- the answer is that I just made it up -- I didn't actually
test the function to see where the breakeven point for ``npp`` might
lie.)


The directive::

  #pragma omp for

indicates that the next for statement should be parallelized across
the threads that were stared with the parallel directive -- that is,
that different threads should get different subsets of the index
``pp`` as it ranges over ``0..npp-1``. In this code, ``pp`` is the
voxel index into the input arrays ``ip``, ``jp``, and ``kp``, and into
the output array ``vv``. The goal of the loop body is to compute
``vv[pp]``. Each different value of ``pp`` writes to a different
output location, so there is no conflict possible even if two threads
were executing the same statement at exactly the same time (something
you always have to think about).


For a ``for`` statement to be parallelizable, the number of iterations
must be easily determinable when the loop is started. In this case, it
is obviously ``npp``. For example, a loop of the form::

  for( pp=0 ; pp < npp && vv[pp] != 666.0f ; pp++ ){ ... }

cannot be parallelized by OpenMP since the terminal condition is not
determinable when the loop is started. Similarly, the loop body cannot
contain any ``break`` statements.

This function (and its analogs for NN, cubic, quintic, and wsinc5
interpolation) were pretty easy to adapt to OpenMP. I simply moved all
the local variables into the ``parallel`` block, and that was about
it. The only write to a variable visible outside the ``parallel``
block is to ``vv[pp]`` and there is obviously no possible thread
conflict there. The only external function called is in the C library,
and these are pretty much all supposed to be "thread-safe" (the
technical term is **re-entrant**), unless the ``man`` page specifies
otherwise.

Note that the parallel ``for`` loop will not be executed in sequential
order of the control variable ``pp``, even within a single
thread. OpenMP chooses the order of execution, so the externally
visible results (in this example, the ``vv[pp]`` values) should not
depend on the order in which the ``pp`` values are chosen. (It is
possible for the programmer to have some control over the division and
sequence of labor in the different threads, but I've not used this
feature of OpenMP, nor do I plan to.)

When parallelizing ``3dDespike``, I chose to parallelize the voxel
loop in the main program. The first thing was to identify all the
variables that receive assignments in this loop, and move the
declarations of those that are purely internal to the loop (not
containing output data) from the top of ``main`` down to be inside the
``parallel`` block. These variables include a number of work arrays
for processing the voxel time series. Each thread gets its own
instance of each of these work arrays, since the ``malloc`` call was
moved inside the ``parallel`` block. I simply had to examine the code
carefully to ensure that every variable that received an assignment
was local to the thread -- since this loop wasn't self-contained
inside a function, the work of scrutinizing the code was a little more
tedious than for the interpolation functions described above. At the
end of the voxel loop, the results are put into the output
dataset. Each voxel calculation and assignment is independent of all
others, so there is no potential thread conflict. However, a couple
more issues arose after I got the code running -- these are described
below in Examples #3 and #4.

Example #2 -- A Little Bit of Restructuring
==============================================

My second example comes from program ``3dTcorrMap.c`` and shows how a
small change to the logic of the program helped OpenMP-ize it. In this
program, the innermost loop is computing the sum (or other
combination) of a lot of calculations. Clearly, when the code is
adding the new result into the accumulating sum, there is the
potential for conflict between two threads executing this summation at
the same time. One way to avoid this conflict is to mark this
statement as being "critical" -- to be only executed by one thread at
a time. The other way to avoid this conflict is to modify the code to
put each iteration's result into a temporary array, and then add the
results up afterwards, outside the ``parallel`` block. The second way is
what I chose to do. Here is the parallelized code::

  float *ccar = (float *)malloc(sizeof(float)*nmask) ;  /* temporary array */

  for( ii=0 ; ii < nmask ; ii++ ){  /* outer loop over voxels: */
                                    /* time series to correlate with */

  xsar = MRI_FLOAT_PTR( IMARR_SUBIM(timar,ii) ) ;      /* ii-th time series */

  #pragma omp parallel
     { int vv,uu ; float *ysar ; float qcc ;
  #pragma omp for
        for( vv=0 ; vv < nmask ; vv++ ){ /* inner loop over voxels */

           if( vv==ii ){ ccar[vv] = 0.0f ; continue ; }
           ysar = MRI_FLOAT_PTR( IMARR_SUBIM(timar,vv) ) ;

           /** dot products (unrolled by 2 on 29 Apr 2009) **/

           if( isodd ){
              for( qcc=xsar[0]*ysar[0],uu=1 ; uu < ntime ; uu+=2 )
                 qcc += xsar[uu]*ysar[uu] + xsar[uu+1]*ysar[uu+1] ;
           } else {
              for( qcc=0.0f,uu=0 ; uu < ntime ; uu+=2 )
                 qcc += xsar[uu]*ysar[uu] + xsar[uu+1]*ysar[uu+1] ;
           }
           ccar[vv] = qcc ; /* save correlation in ccar for later (OpenMP mod) */
        } /* end of inner loop over voxels (vv) */
     } /* end OpenMP */

  /* below here, combine results from ccar[] to get output for voxel #ii */

  } /* end of outer loop over voxels (ii) */


Note that all other variables (besides ``ccar[]``) on the receiving
end of an assignment inside the ``parallel`` block are local variables
inside that block, and so are private to each thread. Note also that
only the loop over ``vv`` is parallelized -- the innermost loops over
``uu`` run sequentially in each thread. In principle, you can nest
``parallel`` blocks, but I have not tried this. OpenMP version 2.5
does not require an implementation to support nested parallelism, and
I've not bothered to try to use this feature.

The original code for the above fragment read like so::

   for( ii=0 ; ii < nmask ; ii++ ){  /* time series to correlate with */

     xsar = MRI_FLOAT_PTR( IMARR_SUBIM(timar,ii) ) ;

     Tcount = Mcsum = Zcsum = Qcsum = 0.0f ;
     for( jj=0 ; jj < nmask ; jj++ ){  /* loop over other voxels, correlate w/ ii */

       if( jj==ii ) continue ;
       ysar = MRI_FLOAT_PTR( IMARR_SUBIM(timar,jj) ) ;

       /** dot products (unrolled by 2 on 29 Apr 2009) **/

       if( isodd ){
         for( cc=xsar[0]*ysar[0],kk=1 ; kk < ntime ; kk+=2 )
           cc += xsar[kk]*ysar[kk] + xsar[kk+1]*ysar[kk+1] ;
       } else {
         for( cc=0.0f,kk=0 ; kk < ntime ; kk+=2 )
           cc += xsar[kk]*ysar[kk] + xsar[kk+1]*ysar[kk+1] ;
       }

       Mcsum += cc ;
       Zcsum += 0.5f * logf((1.0001f+cc)/(1.0001f-cc));
       Qcsum += cc*cc ;
       if( fabsf(cc) >= Thresh ) Tcount++ ;
     } /* end of loop over jj */
     if( Mar != NULL ) Mar[indx[ii]] = Mcsum / (nmask-1.0f) ;
     if( Zar != NULL ) Zar[indx[ii]] = tanh( Zcsum / (nmask-1.0f) ) ;
     if( Qar != NULL ) Qar[indx[ii]] = sqrt( Qcsum / (nmask-1.0f) ) ;
     if( Tar != NULL ) Tar[indx[ii]] = Tcount ;

   } /* end of loop over ii */

Note the summation into ``Mcsum`` and other variables inside the
``jj`` loop -- these are not thread-safe. Instead of storing the
components of ``Mcsum`` into an array ``ccar`` as done in the
OpenMP-ization above, another way would be to force the OpenMP thread
manager to ensure that only one thread at time updates these
variables. This could be done with the following construction::

  #pragma omp critical (TcorrMap)
       { Mcsum += cc ;
         Zcsum += 0.5f * logf((1.0001f+cc)/(1.0001f-cc));
         Qcsum += cc*cc ;
         if( fabsf(cc) >= Thresh ) Tcount++ ;
       }

This OpenMP construction would block more than one thread at a time
from entering the structured block that follows the ``critical``
directive. So why didn't I use this approach to modifying
``3dTcorrMap.c``? The answer is simple -- I wasn't really aware of
``critical`` when I made the changes to the code in the distant past
(3+ weeks ago now). (I probably would have tried that first, but I'm
not going to go back and patch things up just for fun.) Of course,
it's important not to put too much code inside a ``critical`` block,
or that will slow the program down as threads are forced to wait.

Example #3 -- OpenMP and malloc
====================================

The C library functions ``malloc`` etc. are re-entrant, so that's good
-- they can be used inside ``parallel`` blocks with no real
worries. *However,* the tracking wrappers I wrote, ``mcw_malloc``
etc., are not re-entrant, since they use and modify a ``static``
structure to keep track of whats been allocated. Therefore, any
OpenMP-ized function that might call (even indirectly in another
function) an ``cw_malloc`` function must put this call inside a
``critical`` block. This is pretty annoying. You can find some
examples of this in ``3dDespike.c`` and other places. However, later
(about 1 day) I realized that this is unneeded. All you need to do is
not turn on ``mcw_malloc`` in OpenMP-enabled main programs. At the top
of many AFNI main programs is code like so::

  #ifdef USING_MCW_MALLOC
     enable_mcw_malloc() ;
  #endif

This code snippet should be replaced with::

  #if defined(USING_MCW_MALLOC) && !defined(USE_OMP)
     enable_mcw_malloc() ;
  #endif

In this way, a program that gets compiled with OpenMP will not turn on
the ``mcw_malloc`` functions, and life will be cool.

Unfortunately, the same issue arises with the ``NI_malloc`` functions
in the NIML library. I've not decided what to do about those just
yet. These functions (in sub-directory ``niml``) are designed to be
compiled without reference to other AFNI code -- my (unfulfilled)
dream was that other people might like to use these functions for
inter-process communication and data storage, so I didn't want them to
be dependent on the complicated forest of AFNI headers, macros, etc.

Example #4 -- OpenMP and static variables
============================================

Writing to ``static`` variables is a potential thread conflict
problem. When OpenMP-izing ``3dDespike``, I found that there were
differences in the output between the old and new versions in a tiny
number of voxels. This was pretty annoying. After some thought, I
traced the problem down to the Fortran-to-C translated function in
``cl1.c``. All the local variables in the translated code are declared
``static``, since that is the semantics of Fortran-77 (local variable
values persist across function calls, unlike in C). However, the
function doesn't actually re-use any values from old calls, so I
removed all the ``static`` local variable declarations in this translated
code. The two versions of ``3dDespike`` now agreed exactly.

**Lesson A:** when OpenMP-izing, scrutinize all functions being called
for ``static`` variables that might get written into. If you find any,
you'll have to de-``static`` the code, or ``critical``\ -ize the call
to that function. (In the case of ``cl1.c``, the latter choice wasn't
an option, since ``3dDespike`` spends most of its CPU time in that
function.)

**Lesson B:** Be sure to run the program with and without OpenMP and
``diff`` the result files to make sure they are identical. Any differences
need to be investigated, understood, and fixed.

A potential ``static`` problem arises with the function call traceback
macros ``ENTRY`` and ``RETURN``/\ ``EXRETURN`` defined in
``debugtrace.h``. These macros use a ``static`` stack to keep track of
function calls. Clearly, this stack could get confused with OpenMP. To
'fix' this problem, I've defined a macro that should be in as the
first executable statement in a ``parallel`` block, and another as the
last executable statement; for example::

  #pragma omp parallel if(npp > 9999)
   {
     int fred ; /* other declarations ... */
     AFNI_OMP_START ;
     /* parallel code ... */
     AFNI_OMP_END ;
   } /* end OpenMP */

At present, all these macros do is stop and re-start (respectively)
the ``RETURN``/\ ``EXRETURN`` stack operations. In the future, they
may do more things, which is why I wrote them as macros, to be more
flexible.

Example #5 -- OpenMP and random numbers -- AlphaSim
=====================================================

A problem arose when I tried to OpenMP-ize the ``AlphaSim``
program. This code generates a lot of random 3D volumes and processes
them to get some statistics. As it turns out, it spends most its time
(80+%) generating the random numbers. The routine that is used boils
down to the C library function ``drand48()`` and its
ilk. Parallelizing across instances of the volumes seems pretty
straightforward -- but the program becomes much slower. After some
playing around, I found the reason: the ``drand48()`` set of functions
uses an internal "state" to generate the sequence of random variates
-- and this state data is static. To be thread-safe, these library
functions simply block on re-entrancy -- that is, they are all
``critical``. Not very good for speedup!

But there is a solution that doesn't involve writing my own
thread-safe random number generator (which was my first thought, and
which gave me a headache). Instead of ``drand48()`` to get a
``U(0,1)`` random variate, I used the function ``erand48(unsigned
short x[3])``, where the random generation state is stored in the
array ``x[]``. I create a separate state array for each thread (at the
start of the ``parallel`` block, before the parallelized ``for``), and
initialize them separately (so each thread gets a different sequence
of random variates!). This solves the problem, and the program now
runs with nearly perfect speedup. For the tedious details, see the
``AlphaSim.c`` source code -- including the file ``zgaussian.c``,
where the Gaussian ``N(0,1)`` random number generator resides.

Example #6 -- OpenMP and malloc() and memcpy() -- 3dREMLfit
=============================================================

Parallelizing ``3dREMLfit`` effectively and correctly was much harder
than the programs above. The first problem was where to parallelize. I
tried various places, but none of them gave much speedup -- in some
cases, OpenMP slowed the program down significantly. After a long
time, I finally thought of using Apple's Shark profiler program, and
figured out that the program was spending a vast amount of time
spinning threads waiting for ``malloc`` and ``free`` to do their
work. Aha!  The big CPU time sink in the "REML voxel loop",
``REML_func()`` allocates and frees workspace arrays. But this
function is called hundreds of times per voxel, so the threads were
interfering with each other -- because the system memory allocator is
thread-safe simply by blocking -- it is not parallelized itself. I
didn't want to install a parallelized version of ``malloc``, so I
rearranged to code to provide the workspace from outside, so that it
wouldn't constantly be created and destroyed. Speedup!!!

**... But ...** In a sample run with about 133K voxels, about 40-100
voxels did not agree with the single-threaded case. Arrrgghhh!!!
After printing out vast amounts of information from each thread's loop
through the voxels, I finally found that these traitorous voxels in
fact had the wrong data passed to ``REML_func()``. This data time
series vector was copied using ``memcpy``. For whatever reason, this
wasn't completely thread-safe -- I don't know why, and can't find any
other info about this on the Web. But by ``critical``\ -izing this
statement, the problems vanished. Simple .. after 2.5 days of
frustration, that is.

Other minor details in parallelizing this program: the ``-usetemp``
option writes intermediate data to disk and then re-reads it later,
with the assumption that things are written in voxel order. This won't
be true for OpenMP, so a special simpler loop, with all the
``-usetemp`` stuff deleted, was written for the parallel section of
the code. This change makes it easier to deal with the
parallelization, but of course means that any changes to the "REML
voxel loop" must be made twice in the future, since there are now two
different versions of this loop's code extant. *C'est la soft-guerre.*

Example #7 -- Looping over voxels in 3dAutoTcorrelate
=======================================================

This program correlates the time series from all voxels inside a mask
with all other voxels (inside the same mask, or all voxels). In the
original sequential code, the outer loop over voxel index ``ii`` just
tested the voxel index to see if was in the mask -- if not, then it
just ``continue``\ -d to the next voxel. But in OpenMP, this means
that some parallel sub-loops get more work than others, if they happen
to fall into a denser part of the mask. Speedup was not all it should
be. So by pre-making an index table ``imap`` of voxel indexes in the
mask, I could just loop over that table and be sure each loop
iteration was doing the same amount of labor.

Another issue that arose, that had a bigger impact, was the fact that
extracting the time series from the space-then-time ordered input
dataset was inefficient -- since each voxel time series would be
extracted many many times as the inner voxel loop was
traversed. Inverting the input dataset into an ``MRI_vectim`` struct
(time-then-space ordered) provided a big speedup, making memory
accesses much more local. Also, each time series could be
pre-detrended, avoiding repeating this operation many many times.

With these 2 changes, ``3dAutoTcorrelate`` became much faster, and in
fact it now spends a significant fraction of its time just writing the
lengthy results to disk. I suppose this would be the next target for
speedup -- probably by writing each completed sub-brick to the output
``*.BRIK`` file via ``mmap()`` when it is completed.

OpenMP Library Functions
===========================

I've only used a couple of these -- see the specification for the real
scoop.


* ``omp_get_num_procs()`` returns the number of processors OpenMP
  thinks is available -- see the ``PRINT_AFNI_OMP_USAGE`` macro in
  ``mrilib.h``, for example.

* ``omp_get_max_threads()`` returns the maximum number of threads that
  are allowed to be used -- usually, the value from
  ``OMP_NUM_THREADS`` or the number of CPUs on the system.

* ``omp_get_num_threads()`` returns the number of threads executing in
  the current ``parallel`` block -- see ``AlphaSim.c`` for an example
  of how this can be used to allocate workspaces, combined with the
  OpenMP ``master`` and ``barrier``\ \ ``pragma``\ s.

* ``omp_get_thread_num()`` returns the thread number of the executing
  thread (counting starts at 0 for the "master thread") -- this is
  also used in ``AlphaSim.c`` to sum output values into the
  thread-specific workspaces (to avoid collisions between threads).

  * These latter 2 functions should only be used inside ``parallel``
    blocks, since they don't have much utility outside a parallelized
    piece of code.


See the `OpenMP 2.5 specification
<http://www.openmp.org/mp-documents/spec25.pdf>`_ for more details and
a complete list of all such functions, etc.

Printing -help for OpenMP-ized programs
========================================

In ``mrilib.h``, the macro ``PRINT_AFNI_OMP_USAGE(pnam,extra)`` is
defined. When USE_OMP is defined (i.e., on the compile command line
via ``CCOMP``), then this macro prints out some extra help relevant to
OpenMP usage. The argument ```pnam`` is intended to be the program
name, and the argument ``extra`` is any extra text to be put at the
end of the standard boilerplate (``extra`` can be ``NULL``). If
USE_OMP is not defined, then ``PRINT_AFNI_OMP_USAGE(pnam,extra)``
prints a message that the program is OpenMP-compatible, but this
binary copy is not compiled with OpenMP. Thus, this macro is designed
to be inserted at the end of the ``-help`` output section in any
OpenMP-ized program (cf. ``AlphaSim.c``).
