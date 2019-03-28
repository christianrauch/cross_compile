# Copyright (c) 2018, ARM Limited.
# SPDX-License-Identifier: Apache-2.0

if("$ENV{TOOLCHAIN_PATH}" STREQUAL "" OR
   "$ENV{SYSROOT}" STREQUAL "" OR
   "$ENV{ROS2_INSTALL_PATH}" STREQUAL "" OR
   "$ENV{PYTHON_SOABI}" STREQUAL "")
    message(FATAL_ERROR "Target environment variables not defined")
endif()

set(TARGET_ARCH armhf)
set(TARGET_TRIPLE arm-linux-gnueabihf)

set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_VERSION 1)
set(CMAKE_SYSTEM_PROCESSOR ${TARGET_ARCH})

# Specify the cross compiler
# from: https://github.com/ruslo/polly/blob/master/compiler/gcc-cross-compile.cmake
set(TOOLCHAIN_PATH_AND_PREFIX $ENV{TOOLCHAIN_PATH}/${TARGET_TRIPLE})
set(CMAKE_C_COMPILER     "${TOOLCHAIN_PATH_AND_PREFIX}-gcc"     CACHE PATH "C compiler" )
set(CMAKE_CXX_COMPILER   "${TOOLCHAIN_PATH_AND_PREFIX}-g++"     CACHE PATH "C++ compiler" )
set(CMAKE_ASM_COMPILER   "${TOOLCHAIN_PATH_AND_PREFIX}-as"      CACHE PATH "Assembler" )
set(CMAKE_C_PREPROCESSOR "${TOOLCHAIN_PATH_AND_PREFIX}-cpp"     CACHE PATH "Preprocessor" )
set(CMAKE_STRIP          "${TOOLCHAIN_PATH_AND_PREFIX}-strip"   CACHE PATH "strip" )
if( EXISTS "${TOOLCHAIN_PATH_AND_PREFIX}-gcc-ar" )
  # Prefer gcc-ar over binutils ar: https://gcc.gnu.org/wiki/LinkTimeOptimizationFAQ
  set(CMAKE_AR           "${TOOLCHAIN_PATH_AND_PREFIX}-gcc-ar"  CACHE PATH "Archiver" )
else()
  set(CMAKE_AR           "${TOOLCHAIN_PATH_AND_PREFIX}-ar"      CACHE PATH "Archiver" )
endif()
set(CMAKE_LINKER         "${TOOLCHAIN_PATH_AND_PREFIX}-ld"      CACHE PATH "Linker" )
set(CMAKE_NM             "${TOOLCHAIN_PATH_AND_PREFIX}-nm"      CACHE PATH "nm" )
set(CMAKE_OBJCOPY        "${TOOLCHAIN_PATH_AND_PREFIX}-objcopy" CACHE PATH "objcopy" )
set(CMAKE_OBJDUMP        "${TOOLCHAIN_PATH_AND_PREFIX}-objdump" CACHE PATH "objdump" )
set(CMAKE_RANLIB         "${TOOLCHAIN_PATH_AND_PREFIX}-ranlib"  CACHE PATH "ranlib" )
set(CMAKE_RC_COMPILER    "${TOOLCHAIN_PATH_AND_PREFIX}-windres" CACHE PATH "WindowsRC" )
set(CMAKE_Fortran_COMPILER "${TOOLCHAIN_PATH_AND_PREFIX}-gfortran" CACHE PATH "gfortran" )


# Specify the target file system
set(CMAKE_SYSROOT $ENV{SYSROOT})

set(CMAKE_FIND_ROOT_PATH $ENV{ROS2_INSTALL_PATH})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

# Specify the python SOABI
set(PYTHON_SOABI $ENV{PYTHON_SOABI})

if(NOT TARGET Qt5::moc)
  set(QT_MOC_EXECUTABLE /usr/bin/moc)
  add_executable(Qt5::moc IMPORTED)
  set_property(TARGET Qt5::moc PROPERTY IMPORTED_LOCATION ${QT_MOC_EXECUTABLE})
endif()

# This assumes that pthread will be available on the target system
# (this emulates that the return of the TRY_RUN is a return code "0")
set(THREADS_PTHREAD_ARG "0"
  CACHE STRING "Result from TRY_RUN" FORCE)
