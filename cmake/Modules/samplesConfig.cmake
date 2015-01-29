INCLUDE(FindPkgConfig)
PKG_CHECK_MODULES(PC_SAMPLES samples)

FIND_PATH(
    SAMPLES_INCLUDE_DIRS
    NAMES samples/api.h
    HINTS $ENV{SAMPLES_DIR}/include
        ${PC_SAMPLES_INCLUDEDIR}
    PATHS ${CMAKE_INSTALL_PREFIX}/include
          /usr/local/include
          /usr/include
)

FIND_LIBRARY(
    SAMPLES_LIBRARIES
    NAMES gnuradio-samples
    HINTS $ENV{SAMPLES_DIR}/lib
        ${PC_SAMPLES_LIBDIR}
    PATHS ${CMAKE_INSTALL_PREFIX}/lib
          ${CMAKE_INSTALL_PREFIX}/lib64
          /usr/local/lib
          /usr/local/lib64
          /usr/lib
          /usr/lib64
)

INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(SAMPLES DEFAULT_MSG SAMPLES_LIBRARIES SAMPLES_INCLUDE_DIRS)
MARK_AS_ADVANCED(SAMPLES_LIBRARIES SAMPLES_INCLUDE_DIRS)

