# Make sure we have the prerequisits needed by UseLATEX
find_package ( LATEX REQUIRED )
find_package ( ImageMagick REQUIRED )
find_file ( CMAKE_PROJECT_thesis_INCLUDE_FILE "UseLATEX.cmake"
  PATHS "${CMAKE_SOURCE_DIR}" "${CMAKE_CURRENT_SOURCE_DIR}"
  PATH_SUFFIXES "UseLATEX"
  DOC "Location of the CMake UseLATEX.cmake module. See http://public.kitware.com/Wiki/CMakeUserUseLATEX and https://github.com/kmorel/UseLATEX for more information." )
if ( CMAKE_PROJECT_thesis_INCLUDE_FILE MATCHES "NOTFOUND" )
  message ( SEND_ERROR
      "UseLATEX CMake module missing! Please obtain it from https://github.com/kmorel/UseLATEX or http://public.kitware.com/Wiki/CMakeUserUseLATEX." )
endif ( CMAKE_PROJECT_thesis_INCLUDE_FILE MATCHES "NOTFOUND" )
get_filename_component ( UseLATEX_LOC "${CMAKE_PROJECT_thesis_INCLUDE_FILE}" PATH )

# Since target name mangling is off by default, let's not add_subdirectory uselatex
# add_subdirectory ( "${UseLATEX_LOC}" EXCLUDE_FROM_ALL)
