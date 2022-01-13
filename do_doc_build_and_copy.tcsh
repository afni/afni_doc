#!/bin/tcsh

# ======================================================================

# variables controlling what gets done; modified by input flags
set gen_all_opts = () #( "-phelp" )
set DO_BUILD    = 0
set DO_PUSH     = 0
set DO_PHELP    = 0        # prob don't need to change with the opt below
set DO_DEVDOCS  = 0        # [PT: Jan 4, 2020] specific env deps

set USE_SUMAFNI_INIT = 1  # [PT: 28 Dec 2021] use some pre-built SUMA docs
set DO_GEN_AFNI = 0        # [PT: 28 Dec 2021] run AFNI GUI (def: off)
set DO_GEN_SUMA = 0        # [PT: 28 Dec 2021] run SUMA GUI (def: off)


# ======================================================================

# [PT: Mar 8, 2019] add in the afni_handouts processing
# [PT: Jan 4, 2020] add in the option to do J Lee's devdocs building
#                   -> mostly just set to run on 'safni' because of TESTSDIR
#                      def in Makefile
# [PT: Jan 5, 2020] now using local tempdir of afni clone as part of devdocs
#                   make, to be buildable anywhere with the same command
#                   -> added in J Lee's pip uninstall/install fix for
#                      denoting the run_test_utils dir.
#
# [PT: 28 Dec 2021] use some pre-built SUMA doc info, namely images
#                   used in: SUMA/Controller.rst and SUMA/Viewer.rst.
#                   These are now stored on afni
#                   (pub/dist/doc/htmldoc_sumafni_init.tgz), and can
#                   be regenerated if need be (but they don't change
#                   often. Should reduce the number of compile warnings.
 
# ======================================================================

if ( $#argv == 0 ) goto SHOW_HELP

set ac = 1
while ( $ac <= $#argv )
    # terminal options
    if ( ("$argv[$ac]" == "-h" ) || ("$argv[$ac]" == "-help" )) then
        goto SHOW_HELP
    endif

    # required
    if ( "$argv[$ac]" == "-build" ) then
        set DO_BUILD = 1

    else if ( "$argv[$ac]" == "-push" ) then
        set DO_PUSH = 1

    else if ( "$argv[$ac]" == "-devdocs" ) then
        set DO_DEVDOCS = 1

    # [PT: 28 Dec 2021]
    else if ( "$argv[$ac]" == "-no_sumafni_init" ) then
        set USE_SUMAFNI_INIT = 0

    else if ( "$argv[$ac]" == "-gen_all_afni" ) then
        set DO_GEN_AFNI = 1
        set gen_all_opts = ( $gen_all_opts "-afni" )

    else if ( "$argv[$ac]" == "-gen_all_suma" ) then
        set DO_GEN_SUMA = 1
        set gen_all_opts = ( $gen_all_opts "-suma" )

    # this is probably never necessary now
    else if ( "$argv[$ac]" == "-gen_all_phelp" ) then
        set gen_all_opts = ( $gen_all_opts "-phelp" )
        set DO_PHELP = 1

    else
        echo "\n\n** ERROR: unexpected option #$ac = '$argv[$ac]'\n\n"
        goto BAD_EXIT
    endif

    @ ac += 1
end

# ============================ verify ===================================
# [PT: 28 Dec 2021]

if( ${DO_GEN_AFNI} && ${USE_SUMAFNI_INIT} ) then
    echo "** ERROR: cannot make RST files with AFNI GUI while also using"
    echo "   the stored docs online."
    goto BAD_EXIT
endif

if( ${DO_GEN_SUMA} && ${USE_SUMAFNI_INIT} ) then
    echo "** ERROR: cannot make RST files with SUMA GUI while also using"
    echo "   the stored docs online."
    goto BAD_EXIT
endif

# =================== set paths: need AFNI installed ====================

# find where AFNI binaries are
set adir      = ""
which afni >& /dev/null
if ( $status ) then
    echo "** Cannot find 'afni' (??)."
    goto BAD_EXIT
else
    set aa   = `which afni`
    set adir = $aa:h
    echo "++ AFNI binaries located at: $adir"
endif

setenv PYTHONPATH $adir

set here = $PWD
set thedate = `date +%Y_%m_%d`
set backup_dir = htmldoc.auto_backup.$thedate

# for listing handouts
set aho_dir  = /mnt/afni/pub/dist/edu/data/CD.expanded/afni_handouts/
set aho_txt  = afni_handouts_list.txt # in educational/media/
set aho_rst  = afni_handouts_list.rst # in educational/media/

# =============================================================

if ( "$DO_PHELP" == "0" ) then
    set gen_all_opts = ( $gen_all_opts "-no_phelp" )
endif

# =========================== do build ========================

if ( "$DO_BUILD" == "1" ) then

    echo "++ START: Do documentation build"

    # preliminary checks to make sure some things have been installed
    if ( $DO_DEVDOCS ) then

        set env_list = `conda env list | grep afni_dev`
        if ( $status ) then
            echo "** Failure to find 'afni_dev' with 'conda env list'/"
            echo "   Please make sure you have the environment set up."
            exit 1
        endif

        set testdir_make = `grep TESTSDIR Makefile`
        echo "++ Checking that TESTSDIR is set in Makefile (just printing):"
        echo "   ${testdir_make}"
        echo "++ NB: this is probably just set (hard-wired) to run on safni."

    endif

    ### Make preliminary stuff from helpfiles: will open both AFNI and
    ### SUMA this way
    echo "++ STEP: gen_all"
    tcsh @gen_all $gen_all_opts

    # ------------- copy premade pages, maybe --------------------
    # [PT: 28 Dec 2021]

    if ( ${USE_SUMAFNI_INIT} ) then
        echo "++ STEP: use SUMAFNI_INIT pages"

        set dir_sa_init = htmldoc_sumafni_init
        set SUMA_media  = "${dir_sa_init}/SUMA/media/"    # keep slash
        set SUMA_inc    = "${dir_sa_init}/SUMA/auto_inc/" # keep slash
        ##set AFNI_init   = "${dir_sa_init}/AFNI/"          # keep slash
        
        # either download or reuse the directory
        if ( ! -d ${dir_sa_init} ) then 
            echo "++ Download SUMAFNI init dir: '${dir_sa_init}'"
            wget https://afni.nimh.nih.gov/pub/dist/doc/${dir_sa_init}.tgz
            touch ${dir_sa_init}.tgz
            if ( $status ) then
                echo "** ERROR: cannot download ${dir_sa_init}.tgz"
                goto BAD_EXIT
            endif

            tar -xf ${dir_sa_init}.tgz
            touch ${dir_sa_init}
        else
            echo "++ Reuse existing SUMAFNI init dir: '${dir_sa_init}'"
            echo "   (If you *don't* want to reuse it, you better remove it.)"
        endif

        # copy the desired contents over for SUMA
        echo "++ sync or swim"
        rsync -av  ${SUMA_media}         \
            ./SUMA/media
        rsync -av  ${SUMA_inc}           \
            ./SUMA/auto_inc

        ### AT PRESENT, don't do anything with AFNI contents, because
        ### we don't build those anyways
        ##rsync -av --delete  ${AFNI_init}          \
        ##    ./AFNI

    endif

    # ------------- python stuff --------------------
    cd python_help_scripts

    if ( 0 ) then
        echo "++ STEP: Make quickbuild_instructs"
        set dir_instructs = "../background_install/install_instructs"
        python make_substeps_of_quickbuilds.py ${dir_instructs}
    else
        echo "+* STEP (disabled, temporarily): quickbuild_instructs"
        echo "       Don't make separate quickbuild instructs at the moment."
        echo "       Just use quickbuilds written 'as is'; user can read sep."
        echo "       The files are changing too much; may revisit later."
    endif

    echo "++ STEP: Make list of All Program Helps"
    set dir_allhelp = "../programs"
    mkdir -p ${dir_allhelp}
    python help2sphinx.py -OutFolder ${dir_allhelp}

    echo "++ STEP: Make classified/groupings stuff"
    set fieldfile = list_STYLED_NEW.txt
    python convert_list_to_fields_pandas.py        \
        list_AFNI_PROGS_classed.txt                \
        $fieldfile
    python convert_fields_to_rst.py                \
        $fieldfile                                 \
        ../educational/classified_progs.rst

    echo "++ STEP: Make AFNI startup tips RST"
    python make_file_of_startup_tips.py            \
        all_startup_tips.txt                       \
        ../educational/startup_tips.rst

    echo "++ STEP: Make AFNI GUI readme tips RST"
    python make_file_of_gui_readme_tips.py         \
        all_gui_tips.txt                           \
        ../educational/gui_readme_tips.rst

    echo "++ STEP: Make AFNI environment variable RST"
    python make_file_of_readme_env.py              \
        all_env_vars.txt                           \
        ../educational/readme_env_vars.rst

    echo "++ STEP: Make AFNI colorbars RST"
    python make_file_of_all_afni_cbars.py          \
        ../educational/media/cbars                 \
        ../educational/all_afni_cbars.rst

    # [PT: Mar 8, 2019] added
    if ( -e $aho_dir ) then
        echo "++ STEP: List AFNI handouts"
        \ls -1 ${aho_dir} > ../educational/media/${aho_txt}

        python convert_handouts_list_to_table.py \
            ../educational/media/${aho_txt}      \
            ../educational/media/${aho_rst}
    else
        echo "** Could not find list during build **" \
            > ../educational/media/${aho_rst}
    endif

    cd ..
    # ---------------------------------

    if ( $DO_DEVDOCS ) then
        echo "++ Build Sphinx html with devdocs"
        echo "   ... from: $PWD"

        # need this env running for devdocs
        conda activate afni_dev

        # the afni_dev env specifies one specific dir for getting the
        # afni_test_utils module.  First use pip to *undo* that
        # specification here, then specify that new location (from tmp
        # dir)
        ### *if* we move to using a static git repo for afni, then we
        ### could build the afni_dev env there, and we wouldn't need
        ### these pips.
        pip uninstall afni_test_utils
        pip install -e _tmp_git/afni/tests

        # the Makefile has TESTSDIR set for here ("--depth 1" for
        # speed/size of clone)
        \mkdir -p _tmp_git
        cd _tmp_git
        git clone --depth 1 https://github.com/afni/afni.git
        cd -

        echo "++ ... now do the 'make' with devdocs"
        make html_with_devdocs

        echo "++ ... done with make, just deactivating conda env."

        \rm -rf _tmp_git

        conda deactivate

    else
        echo "++ Build regular Sphinx html"
        make html
    endif

endif

# =========================== do push ========================

#if ( "$DO_PUSH" == "1" ) then
#    echo "++ Pushin' the current docs over to afni (and the World)."
#    rsync -av --delete _build/html/         \
#        afni.nimh.nih.gov:/fraid/pub/dist/doc/htmldoc
#    echo "++ ... and done pushing the docs.\n"
#endif
if ( "$DO_PUSH" == "1" ) then
    echo "++ Pushin' the current docs as <<afniHQ>>"
    echo     " over to afni (and the World)."
    rsync -av --delete _build/html/         \
        afniHQ@afni.nimh.nih.gov:/fraid/pub/dist/doc/htmldoc
    echo "++ ... and done pushing the docs.\n"
endif

goto GOOD_EXIT


SHOW_HELP:
cat << EOF
-------------------------------------------------------------------------

Build and push AFNI et al. documentation. 

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

OPTIONS

    -build      :signal doc build.

    -push       :will rsync the docs over to afni; if no "-build" is used,
                 then it will sync whatever is there at present.

    -gen_all_afni :do the AFNI pictures-help stuff.
    -gen_all_suma :do the SUMA pictures-help stuff.

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

RUNNING

To just *build* docs locally:
    do_doc_build_and_copy.tcsh -build

To just build docs locally *and* push:
    do_doc_build_and_copy.tcsh -build -push

To just build docs locally *and* push *and* build AFNI/SUMA picture docs:
    do_doc_build_and_copy.tcsh -build -push -gen_all_afni -gen_all_suma 

A backup doc dir from the server can be removed later.

-------------------------------------------------------------------------
EOF

    goto GOOD_EXIT

BAD_EXIT:
    echo "\n++ Better luck next time -- bye\n"
    exit 1

GOOD_EXIT:
    echo "\n++ Successfully accomplished your endeavors-- bye\n"
    exit 0
