# Base EFM32 CMake file
#
# This can be used as is as a project base, or by adding the efm32-base
# repository as a submodule to another project, copying this CMakeLists file
# to the top level directory, and updating the BASE_LOCATION variable to reflect this
# change
#
## Copyright (c) 2016 Ryan Kurte
# This file is covered under the MIT license available at: https://opensource.org/licenses/MIT

###### Project Environment #####

# Set minimum CMake version
cmake_minimum_required(VERSION 2.8.4)

# Set balenafin project location
set(BASE_LOCATION .)

# Set the compiler (must be prior to project setup)
include(${BASE_LOCATION}/toolchain/arm-gcc.cmake)

##### Project Setup #####

# Set our output target
set(TARGET balenafin)

# Configure project and languages
project(${TARGET} C CXX ASM)

# Set default device
if(NOT DEVICE)
set(DEVICE EFR32BG1B232F256GM48)
endif()

# Setup serial interface
if(NOT SERIAL)
set(SERIAL DEV)
endif()

# Set build
if(NOT CMAKE_BUILD_TYPE)
set(CMAKE_BUILD_TYPE DEBUG)
endif()

##### Modules #####

# Libraries can be added to the LIBS variable
# or manually included here.

# Add base libs (emlib, emdrv, CMSIS, device files)
include(${BASE_LOCATION}/toolchain/balenafin.cmake)

##### Files #####

# Add project headers
include_directories(
	${BASE_LOCATION}/include
)

add_subdirectory(${BASE_LOCATION}/cmsis)
add_subdirectory(${BASE_LOCATION}/emlib)
add_subdirectory(${BASE_LOCATION}/emdrv)
add_subdirectory(${BASE_LOCATION}/device)
add_subdirectory(${BASE_LOCATION}/protocol)
add_subdirectory(${BASE_LOCATION}/balena)

# Add project sources
set(SOURCES
	${BASE_LOCATION}/source/main.cpp
)

##### Outputs #####

# Generate executable and link
add_executable(${TARGET} ${SOURCES})

##### Git Versioning #####

# Add build tag to firmware version
find_package(Git)
add_custom_target(version
  ${CMAKE_COMMAND} -D SRC=${CMAKE_SOURCE_DIR}/toolchain/version.h.in
                   -D DST=${CMAKE_SOURCE_DIR}/balena/inc/version.h
                   -D GIT_EXECUTABLE=${GIT_EXECUTABLE}
                   -P ${CMAKE_SOURCE_DIR}/toolchain/version.cmake
)
add_dependencies(${TARGET} version)

target_link_libraries(${TARGET} ${LIBS} emlib emdrv cmsis device balena)

##### Post build #####

# Add post build commands
include(${BASE_LOCATION}/toolchain/post-build.cmake)

# Add JLink commands
include(${BASE_LOCATION}/toolchain/jlink.cmake)
