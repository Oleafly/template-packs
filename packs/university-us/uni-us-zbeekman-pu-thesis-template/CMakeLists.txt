cmake_minimum_required ( VERSION 2.8 FATAL_ERROR )
include ( CMake/checkOutOfSource.cmake )
include ( CMake/checkPackages.cmake )
project ( thesis NONE ) # Includes UseCMAKE.cmake found in checkPackages

set ( PUTHESIS_FONT_SIZE "12pt"
  CACHE STRING "Set the font size, 12pt preferred for serif fonts and 10pt for sans-serif fonts" )
set_property ( CACHE PUTHESIS_FONT_SIZE
  PROPERTY STRINGS "12pt" "10pt" )

option ( PUTHESIS_DRAFT "Make a draft without frontmatter, showing overfull hboxes, using small images" OFF )
if ( PUTHESIS_DRAFT )
  set ( DRAFT ",draft" )
  set ( DRAFTMODE_CTRL "CMake turned on draftmode \n" )
  set ( LATEX_SMALL_IMAGES ON ) # Should override option in cache
endif ( PUTHESIS_DRAFT )

option ( PUTHESIS_LOT "Include a list of tables in the front matter" ON )
if ( PUTHESIS_LOT )
  set ( LOT ",lot" )
endif ( PUTHESIS_LOT )

option ( PUTHESIS_LOF "Include a list of figures in the front matter" ON )
if ( PUTHESIS_LOF )
  set ( LOF ",lof" )
endif ( PUTHESIS_LOF )

# This appears to be broken and losymbol.sty out of date.
# option ( PUTHESIS_LOS "Include a list of symbols in the front matter" OFF )
# if ( PUTHESIS_LOS )
#   set ( LOS ",los" )
# endif ( PUTHESIS_LOS )

set ( PUTHESIS_OUTPUT_TYPE digital
  CACHE STRING "Build for print, proquest, or digital--see the template for more info")

set_property ( CACHE PUTHESIS_OUTPUT_TYPE
  PROPERTY STRINGS "digital" "proquest" "print" )

if ( PUTHESIS_OUTPUT_TYPE STREQUAL "digital" )
  set ( DIGITALMODE_CTRL "CMake turned on digitalmode \n" )
elseif ( PUTHESIS_OUTPUT_TYPE STREQUAL "print" )
  set ( PRINTMODE_CTRL "CMake turned on printmode \n" )
elseif ( PUTHESIS_OUTPUT_TYPE STREQUAL "proquest" )
  set ( DIGITALMODE_CTRL "CMake turned on proquestmode \n" )
  set ( PROQUESTMODE_CTRL "CMake turned on proquestmode \n" )
endif ( PUTHESIS_OUTPUT_TYPE STREQUAL "digital" )

include ( UseLATEX/UseLATEX.cmake )

set ( THESIS_INCLUDES
  abstract.tex acknowledgements.tex
  ch-appendicies/implementation.tex
  ch-appendicies/printing.tex
  ch-conclusion/chapter-conclusion.tex
  ch-conclusion/conclusion.tex
  ch-conclusion/futurework.tex
  ch-intro/chapter-intro.tex
  ch-intro/intro_contributions.tex
  ch-pastwork/chapter-pastwork.tex
  ch-pastwork/topic1.tex
  ch-pastwork/topic2.tex
  ch-usage/chapter-usage.tex
  ch-usage/usage_options.tex
  ch-building/chapter-building.tex)

set ( THESIS_IMAGE_DIRS
  ch-pastwork/figures )

ADD_LATEX_DOCUMENT ( thesis.tex
  INPUTS ${THESIS_INCLUDES}
  CONFIGURE thesis.tex
  BIBFILES thesis.bib
  IMAGE_DIRS ${THESIS_IMAGE_DIRS}
  DEFAULT_PDF
  )
