# Copyright 2011 Free Software Foundation, Inc.
#
# This file is part of GNU Radio
#
# GNU Radio is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3, or (at your option)
# any later version.
#
# GNU Radio is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with GNU Radio; see the file COPYING.  If not, write to
# the Free Software Foundation, Inc., 51 Franklin Street,
# Boston, MA 02110-1301, USA.

########################################################################
# Include python install macros
########################################################################
include(GrPython)
if(NOT PYTHONINTERP_FOUND)
    return()
endif()


# Pick up all .grc files. Rerun cmake when adding new ones.
file(GLOB grc_files "*.grc")


# Finds the grcc executable.
find_program(GRCC_EXEC grcc)
if(GRCC_EXEC)
  message(STATUS "GRCC executable: ${GRCC_EXEC}")
else(GRCC_EXEC)
  message(FATAL_ERROR "GRCC executable not found.")
endif(GRCC_EXEC)


# For each GRC file, execute grcc and place the result in the build
# directory. Also creates a list "grc_py_name" that stores the full
# file names of all of the pre-built python files.
foreach(f ${grc_files})
  message(STATUS "Processing File: ${f}")
  execute_process(COMMAND ${GRCC_EXEC} ${f} -d ${CMAKE_BINARY_DIR}/python)
  string(REPLACE ".grc" ".py" tmp_name ${f})
  string(REPLACE "${CMAKE_SOURCE_DIR}" "${CMAKE_BINARY_DIR}" grc_py_name ${tmp_name})
  list(APPEND py_files "${grc_py_name}")
endforeach(f ${grc_files})


#install the .grc files directly
install(
    FILES
    ${grc_files}
    DESTINATION ${GR_PKG_EXAMPLES_DIR}
    COMPONENT "samples_python"
)


# Install the .py files built using grcc
GR_PYTHON_INSTALL(PROGRAMS
  ${py_files}
  DESTINATION ${GR_PKG_EXAMPLES_DIR}
  COMPONENT "samples_python"
)

########################################################################
# Handle the unit tests
########################################################################
include(GrTest)

set(GR_TEST_TARGET_DEPS gnuradio-samples)
set(GR_TEST_PYTHON_DIRS ${CMAKE_BINARY_DIR}/swig)
