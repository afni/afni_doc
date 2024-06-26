# -*- coding: utf-8 -*-
#
# SUMA and FATCAT docs documentation build configuration file, created by
# sphinx-quickstart on Mon Oct 27 17:05:08 2014.
#
# This file is execfile()d with the current directory set to its
# containing dir.
#
# Note that not all possible configuration values are present in this
# autogenerated file.
#
# All configuration values have a default; values that are commented out
# serve to show the default.
#
###########################################################################
#
# [PT: July 26, 2018]
# + including hidden code block extensions: toggle code blocks shown/hidden
#
# [PT: May 13, 2019] updated to deal with subprocess returning 'bytes'
# type stdout; that simply gets converted to string.
#
# [JR: June 14, 2022] added sphinx_toolbox for some added functionality
# Specifically collapsing sections
#
# [PT: June 14, 2022] backed out sphinx_toolbox at present...
###########################################################################

import sys
import os

import subprocess

# CLOUD: import Cloud
import cloud_sptheme as csp

### In the old days, one uesd to have to install each of these with a
### package manager/pip:
# $ pip install cloud_sptheme
# $ pip install pbr
# $ pip install sphinxcontrib-fulltoc
# $ pip install sphinxcontrib.programoutput
# $ pip install sphinx-argparse
# $ apt install pandoc
### BUT nowadays, one should be able to use the included
### environment.yml file and create a conda env with all necessary
### dependencies (assuming you have AFNI binaries installed and ready
### to run)

def setup(app):
    app.add_css_file('style.css')
    ### apparently, the following is now deprecated: 
    #app.add_stylesheet('style.css')

# If extensions (or modules to document with autodoc) are in another directory,
# add these directories to sys.path here. If the directory is relative to the
# documentation root, use os.path.abspath to make it absolute, like shown here.
sys.path.insert(0, os.path.abspath('.'))

# -- General configuration ------------------------------------------------

# If your documentation needs a minimal Sphinx version, state it here.
#needs_sphinx = '1.0'

# Add any Sphinx extension module names here, as strings. They can be
# extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
# ones.
# PT: put in the fulltoc line

# PT: Oct, 2015: switching from 'sphinx.ext.pngmath' module to
# 'mathjax', because I think the former looks muuuch better when
# rendered online.  Still have to check about the 'make latexpdf', but
# that has issues of its own at the moment.
# PT: Jan 12, 2022: add sphinx_copybutton
extensions = [
    'sphinxcontrib.fulltoc',
    'sphinx.ext.imgmath', #'sphinx.ext.mathjax',
    'sphinx.ext.todo',
    'cloud_sptheme.ext.table_styling',
    'sphinxcontrib.programoutput',
    'sphinx.ext.doctest',
    'sphinxarg.ext',
    'hidden_code_block',
    'sphinx_copybutton'
]
####### PT: In order to be able to read equations offline, I'm now
####### switching from mathjax to imgmath; distributing mathjax might
####### be too large, but will investigate that, too.  build machine
####### must also have: dvipng or dvisvgm see:
####### http://www.sphinx-doc.org/en/1.6/ext/math.html#module-sphinx.ext.imgmath
####### for more useful info.  Also, using 'svg' images, because they
####### seem sharper.
html_math_renderer     = 'imgmath'
imgmath_image_format   = 'svg'
imgmath_font_size      = 14
# use "--exact" so that the math text boxes don't get clipped
imgmath_dvisvgm_args   = ['--no-fonts', '--exact'] 
# use textcomp and mathptmx to get heavier (= easier to read) fonts in
# the math eqs
imgmath_latex_opts     = ["\\usepackage{textcomp}", 
                          "\\usepackage{mathptmx}"]
imgmath_latex_preamble = "".join(imgmath_latex_opts)
###mathjax_path = 'https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_CHTML' # http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML'

imgmath_embed = True ### put in to fix having wrong path encoded,
                     ### should be ../_images/math but instead is just
                     ### _images/math

todo_include_todos = True

# Add any paths that contain templates here, relative to this directory.
templates_path = ['_templates']

# The suffix of source filenames.
source_suffix = '.rst'

# The encoding of source files.
#source_encoding = 'utf-8-sig'

# The master toctree document.
master_doc = 'index'

# [PT: March 29, 2018] Had to change way of getting version number,
# because will do build elsewhere now, and AFNI_version*txt are not
# Python files
wafni = subprocess.check_output("which afni",
                                stderr=subprocess.STDOUT,
                                shell=True)
# need to decode bytes -> str
if type(wafni) == bytes :
    wafni = wafni.decode("utf-8")
    
print("++ Path to AFNI_version.txt: \n\t{}".format(wafni[:-5]))

# get the version number of AFNI
fname_version = wafni[:-5] + 'AFNI_version.txt'
fff = open(fname_version, 'r')
x = fff.readlines()
fff.close()
line_in = x[0].strip()
asf_ver = line_in.split('_')[1]

# General information about the project.
project = 'AFNI, SUMA and FATCAT: v%s' % asf_ver
copyright = '2014, AFNI Gurus'

# The version info for the project you're documenting, acts as replacement for
# |version| and |release|, also used in various other places throughout the
# built documents.
#
# SETTING THIS TO HOLD THE AFNI VERSION:
version = asf_ver #'2.0'
# The full version, including alpha/beta/rc tags.
release = '2.1'

# The language for content autogenerated by Sphinx. Refer to documentation
# for a list of supported languages.
#
# This is also used if you do content translation via gettext catalogs.
# Usually you set "language" from the command line for these cases.
language = None

# There are two options for replacing |today|: either, you set today to some
# non-false value, then it is used:
#today = ''
# Else, today_fmt is used as the format for a strftime call.
today_fmt = '%B %d, %Y'

# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
exclude_patterns = ['_build', 
                    'htmldoc_sumafni_init']

# The reST default role (used for this markup: `text`) to use for all
# documents.
#default_role = None

# If true, '()' will be appended to :func: etc. cross-reference text.
#add_function_parentheses = True

# If true, the current module name will be prepended to all description
# unit titles (such as .. function::).
#add_module_names = True

# If true, sectionauthor and moduleauthor directives will be shown in the
# output. They are ignored by default.
#show_authors = False

# The name of the Pygments (syntax highlighting) style to use.
pygments_style = 'sphinx'

# A list of ignored prefixes for module index sorting.
#modindex_common_prefix = []

# If true, keep warnings as "system message" paragraphs in the built documents.
#keep_warnings = False


# -- Options for HTML output ----------------------------------------------

# The theme to use for HTML and HTML Help pages.  See the documentation for
# a list of builtin themes.
#html_theme = 'default'
# CLOUD: set the html theme; there is also a red-colored version named
# "redcloud"
html_theme = "cloud"

# Theme options are theme-specific and customize the look and feel of a theme
# further.  For a list of options available for each theme, see the
# documentation.
# CLOUD: [optional] set some of the options listed above...
# Many of the following are listed here:
# /usr/local/lib/python2.7/dist-packages/cloud_sptheme/themes/cloud/theme.conf
### Note for the main text font ('bodyfont'): rather than using
### 'bodyfont' in this dictionary, the main text font should be
### controlled in _static/style.css and the *.ttf files there,
### specifying the body->font-family there
#### **BUT** note that we now include bodyfont/fontscssurl here, too,
#### with the same font, so that googleapis is not pinged, because
#### that will slow down page viewing even from just local copy
html_theme_options = { 
    "stickysidebar": "true",
    "collapsiblesidebar": "true",
    "defaultcollapsed": "false",
    "roottarget": "index",
    "min_height": "12in",
    "max_width": "12in",
    "lighter_header_decor": "true",
    "linkcolor": "#1874CD",
    "bgcolor": "#F5F5F5",
    "bodyfont": "local_PT_sans",  
    "fontcssurl" : "local_PT_sans",
    #"bodyfont": "PT Sans, sans-serif",
    #"fontcssurl" : "//fonts.googleapis.com/css?family=PT+Sans|Noticia+Text|Open+Sans|Droid+Sans+Mono|Roboto",
    "bodylineheight": "1.4em",
    "codevarfont":  "Menlo,  monospace",
    "codeblockfont": "Menlo, monospace",
    "codetrimcolor": "#E0EEE0",
    "codebgcolor":   "#E0EEE0",
    "highlightcolor": "#FFEC8B",
    "sectionbgcolor" : "#800000", #"#FFEC8B", #"#f5dd4e", #"#F2D41E",
    "headtextcolor": "#8B0000",
    "headlinkcolor": "#8B0000",
    "rubricbgcolor": "#8B0000",
    "headtextcolor": "#8B0000",
    "externalrefs": "false",
    # "externalicon": "",   # another way to turn off/reset arrow to ext links
    "headlinkcolor": "#8B0000"
}  
#    "bodyfont": "Arial",
#    "borderless_decor": "true", 
#    "linkcolor": "#009ACD",
#    "bodyfont": "Lucida Sans Unicode, sans-serif",

# Adding fonts from googleapis described here:
# https://developers.google.com/fonts/docs/getting_started
# in the "theme.conf" file, above

# Add any paths that contain custom themes here, relative to this directory.
#html_theme_path = []
# CLOUD: set the theme path to point to cloud's theme data
html_theme_path = [csp.get_theme_dir()]

# The name for this set of Sphinx documents.  If None, it defaults to
# "<project> v<release> documentation".
#html_title = "%s (doc v%s)  " % (project, release) #None
html_title = "%s" % (project) # don't need doc version number

# A shorter title for the navigation bar.  Default is the same as html_title.
#html_short_title = None

# The name of an image file (relative to this directory) to place at the top
# of the sidebar. Updated to deal with variable change in Sphinx v>=6.0.0.
html_logo = "AFNISUMA.jpg" # None
logo_url  = html_logo

# The name of an image file (within the static path) to use as favicon of the
# docs.  This file should be a Windows icon file (.ico) being 16x16 or 32x32
# pixels large.
#html_favicon = None

# Add any paths that contain custom static files (such as style sheets) here,
# relative to this directory. They are copied after the builtin static files,
# so a file named "default.css" will overwrite the builtin "default.css".
html_static_path = ['_static']

# Add any extra paths that contain custom files (such as robots.txt or
# .htaccess) here, relative to this directory. These files are copied
# directly to the root of the documentation.
#html_extra_path = []

# If not '', a 'Last updated on:' timestamp is inserted at every page bottom,
# using the given strftime format.
#html_last_updated_fmt = '%b %d, %Y'

# If true, SmartyPants will be used to convert quotes and dashes to
# typographically correct entities.
#html_use_smartypants = True

# Custom sidebar templates, maps document names to template names.
# PT: sidebar specs, to be honest, don't know all the features, 
#    but these seem ~nice?
html_sidebars = {
    '**': ['globaltoc.html', 'sourcelink.html', 'searchbox.html'],
    'using/windows': ['windowssidebar.html', 'searchbox.html'],
}

# Additional templates that should be rendered to pages, maps page names to
# template names.
#html_additional_pages = {}

# If false, no module index is generated.
#html_domain_indices = True

# If false, no index is generated.
#html_use_index = True

# If true, the index is split into individual pages for each letter.
#html_split_index = False

# If true, links to the reST sources are added to the pages.
#html_show_sourcelink = True

# If true, "Created using Sphinx" is shown in the HTML footer. Default is True.
#html_show_sphinx = True

# If true, "(C) Copyright ..." is shown in the HTML footer. Default is True.
html_show_copyright = False

# If true, an OpenSearch description file will be output, and all pages will
# contain a <link> tag referring to it.  The value of this option must be the
# base URL from which the finished HTML is served.
#html_use_opensearch = ''

# This is the file name suffix for HTML files (e.g. ".xhtml").
#html_file_suffix = None

# Language to be used for generating the HTML full-text search index.
# Sphinx supports the following languages:
#   'da', 'de', 'en', 'es', 'fi', 'fr', 'hu', 'it', 'ja'
#   'nl', 'no', 'pt', 'ro', 'ru', 'sv', 'tr'
#html_search_language = 'en'

# A dictionary with options for the search language support, empty by default.
# Now only 'ja' uses this config value
#html_search_options = {'type': 'default'}

# The name of a javascript file (relative to the configuration directory) that
# implements a search results scorer. If empty, the default will be used.
#html_search_scorer = 'scorer.js'

# Output file base name for HTML help builder.
htmlhelp_basename = 'ASFdocsdoc'

# -- Options for LaTeX output ---------------------------------------------

latex_elements = {
# The paper size ('letterpaper' or 'a4paper').
#'papersize': 'letterpaper',

# The font size ('10pt', '11pt' or '12pt').
#'pointsize': '10pt',

# Additional stuff for the LaTeX preamble.
#'preamble': '',

# Latex figure (float) alignment
#'figure_align': 'htbp',
}

# Grouping the document tree into LaTeX files. List of tuples
# (source start file, target name, title,
#  author, documentclass [howto, manual, or own class]).
latex_documents = [
  ('index', 'ASFdocs.tex', 
   'AFNI, SUMA and FATCAT docs Documentation',
   'AFNI Gurus', 'manual'),
]

# The name of an image file (relative to this directory) to place at the top of
# the title page.
#latex_logo = None

# For "manual" documents, if this is true, then toplevel headings are parts,
# not chapters.
#latex_use_parts = False

# If true, show page references after internal links.
#latex_show_pagerefs = False

# If true, show URL addresses after external links.
#latex_show_urls = False

# Documents to append as an appendix to all manuals.
#latex_appendices = []

# If false, no module index is generated.
#latex_domain_indices = True


# -- Options for manual page output ---------------------------------------

# One entry per manual page. List of tuples
# (source start file, name, description, authors, manual section).
man_pages = [
    ('index', 'ASFdocs', 
     'AFNI, SUMA and FATCAT docs Documentation',
     ['AFNI Gurus'], 1)
]

# If true, show URL addresses after external links.
#man_show_urls = False


# -- Options for Texinfo output -------------------------------------------

# Grouping the document tree into Texinfo files. List of tuples
# (source start file, target name, title, author,
#  dir menu entry, description, category)
texinfo_documents = [
  ('index', 'ASFdocs', 'AFNI, SUMA and FATCAT docs Documentation',
   'AFNI Gurus', 'ASFdocs', 'One line description of project.',
   'Miscellaneous'),
]

# Documents to append as an appendix to all manuals.
#texinfo_appendices = []

# If false, no module index is generated.
#texinfo_domain_indices = True

# How to display URL addresses: 'footnote', 'no', or 'inline'.
#texinfo_show_urls = 'footnote'

# If true, do not generate a @detailmenu in the "Top" node's menu.
#texinfo_no_detailmenu = False



