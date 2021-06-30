cmake_minimum_required(VERSION 3.10)
project(ug)

include("${PROJECT_SOURCE_DIR}/cmake/functions.cmake")

ug_initialize()
ug_enable_testing()
ug_enable_protobuf()
ug_enable_pcl()
ug_enable_openmp()
ug_enable_g2o()
ug_enable_opencv()
ug_enable_yaml()
ug_enable_fastrtps()


set(CMAKE_BUILD_TYPE "Debug")
set(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin)
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    set(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/lib/debug)
else ()
    set(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/lib/release)
endif()

add_subdirectory(cyber)


