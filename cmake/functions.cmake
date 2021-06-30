include(CMakeParseArguments)

macro(_parse_arguments ARGS)
  set(OPTIONS
    USES_CERES
    USES_EIGEN
    USES_GLOG
    USES_BOOST  
    USES_OPENCV
    USES_PCL
    USES_PANGOLIN
    USES_YAML_CPP
    USES_FASTRTPS
    USES_FASTCDR
    USES_G2O
    USES_GTSAM
    USES_PROJ4
  )
  set(ONE_VALUE_ARG)
  set(MULTI_VALUE_ARGS SRCS HDRS DEPENDS)
  cmake_parse_arguments(ARG
    "${OPTIONS}" "${ONE_VALUE_ARG}" "${MULTI_VALUE_ARGS}" ${ARGS})
endmacro(_parse_arguments)

macro(_common_compile_stuff VISIBILITY)
  set(TARGET_COMPILE_FLAGS "${TARGET_COMPILE_FLAGS} ${GOOG_CXX_FLAGS}")
  set_target_properties(${NAME} PROPERTIES
    COMPILE_FLAGS ${TARGET_COMPILE_FLAGS})

  if(ARG_USES_EIGEN)
    target_include_directories("${NAME}" SYSTEM ${VISIBILITY}
      "${EIGEN3_INCLUDE_DIR}")
    target_link_libraries("${NAME}" "${EIGEN3_LIBRARIES}")
  endif()

  if(ARG_USES_CERES)
    target_include_directories("${NAME}" SYSTEM ${VISIBILITY}
      "${CERES_INCLUDE_DIRS}")
    target_link_libraries("${NAME}" "${CERES_LIBRARIES}")
  endif()

  if(ARG_USES_BOOST)
    target_include_directories("${NAME}" SYSTEM ${VISIBILITY}
      "{Boost_INCLUDE_DIRS}")
    target_link_libraries("${NAME}" "${Boost_LIBRARIES}")
  endif()

  if(ARG_USES_GLOG)
    include_directories(BEFORE ${GLOG_INCLUDE_DIRS})
    target_link_libraries("${NAME}" glog gflags)
  endif()

  if(ARG_USES_LUA)
    target_include_directories("${NAME}" SYSTEM ${VISIBILITY}
      "${LUA_INCLUDE_DIR}")
    target_link_libraries("${NAME}" "${LUA_LIBRARIES}")
  endif()

  if(ARG_USES_RCS)
    target_link_libraries("${NAME}" rcs)
  endif()

  if(ARG_USES_OPENCV)
    include_directories("${NAME}" ${OpenCV_INCLUDE_DIRS})
    target_link_libraries("${NAME}" ${OpenCV_LIBRARIES})
  endif()

  if(ARG_USES_CAIRO)
    PKG_SEARCH_MODULE(CAIRO REQUIRED cairo>=1.12.16)
    include_directories("${NAME}" ${CAIRO_INCLUDE_DIRS})
    target_link_libraries("${NAME}" ${CAIRO_LIBRARIES})
  endif()

  if(ARG_USES_PCL)
    target_link_libraries("${NAME}" ${PCL_LIBRARIES})
  endif()


  if(ARG_USES_PANGOLIN)
#    link_directories(${Pangolin_LIBRARIES})

#    include_directories("${NAME}" ${Pangolin_INCLUDE_DIRS})
#    link_directories("${NAME}" ${Pangolin_LIBRARIES})
    target_link_libraries("${NAME}" ${Pangolin_LIBRARIES})
  endif()

  if(ARG_USES_YAML_CPP)
    target_link_libraries("${NAME}" yaml-cpp)
  endif()

  if(ARG_USES_FASTRTPS)
    find_library(FASTRTPS_LIB fastrtps /usr/local/fast-rtps/lib /usr/local/lib NO_DEFAULT_PATH)
    target_link_libraries("${NAME}" ${FASTRTPS_LIB})
  endif()
  
  if(ARG_USES_FASTCDR)
    find_library(FASTCDR_LIB fastcdr /usr/local/fast-rtps/lib /usr/local/lib NO_DEFAULT_PATH)
    target_link_libraries("${NAME}" ${FASTCDR_LIB})
  endif()

  if(ARG_USES_PROJ4)
    find_library(PROJ4_LIB proj /usr/local/lib NO_DEFAULT_PATH)
    target_link_libraries("${NAME}" ${PROJ4_LIB})
  endif()

  # Add the binary directory first, so that port.h is included after it has
  # been generated.
  target_include_directories("${NAME}" ${VISIBILITY} "${CMAKE_BINARY_DIR}")
  target_include_directories("${NAME}" ${VISIBILITY} "${CMAKE_SOURCE_DIR}")

  foreach(DEPENDENCY ${ARG_DEPENDS})
    target_link_libraries(${NAME} ${DEPENDENCY})
  endforeach()

  # Figure out where to install the header. The logic goes like this: either
  # the header is in the current binary directory (i.e. generated, like port.h)
  # or in the current source directory - a regular header. It could also
  # already be absolute (i.e. generated through a ug_proto_library rule).
  # In all cases we want to install the right header under the right subtree,
  # e.g. foo/bar/baz.h.in will be installed from the binary directory as
  # 'include/foo/bar/baz.h'.
  foreach(HDR ${ARG_HDRS})
    if (EXISTS ${CMAKE_CURRENT_BINARY_DIR}/${HDR})
      set(ABS_FIL "${CMAKE_CURRENT_BINARY_DIR}/${HDR}")
      file(RELATIVE_PATH REL_FIL ${CMAKE_BINARY_DIR} ${ABS_FIL})
    elseif(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/${HDR})
      set(ABS_FIL "${CMAKE_CURRENT_SOURCE_DIR}/${HDR}")
      file(RELATIVE_PATH REL_FIL ${CMAKE_SOURCE_DIR} ${ABS_FIL})
    else()
      set(ABS_FIL "${HDR}")
      file(RELATIVE_PATH REL_FIL ${CMAKE_BINARY_DIR} ${ABS_FIL})
    endif()
    get_filename_component(INSTALL_DIR ${REL_FIL} DIRECTORY)
    install(
      FILES
        ${ABS_FIL}
      DESTINATION
        include/${INSTALL_DIR}
    )
  endforeach()
endmacro(_common_compile_stuff)

# Create a static library out of other static libraries by running a GNU ar
# script over the dependencies.
function(google_combined_library NAME)
  set(MULTI_VALUE_ARGS SRCS)
  cmake_parse_arguments(ARG "" "" "${MULTI_VALUE_ARGS}" ${ARGN})

  # Cmake requires a source file for each library, so we create a dummy file
  # that is empty. Its creation depends on all libraries we want to include in
  # our combined static library, i.e. it will be touched whenever any of them
  # change, which means that our combined library is regenerated.
  set(DUMMY_SOURCE ${CMAKE_CURRENT_BINARY_DIR}/${NAME}_dummy.cc)
  add_custom_command(
    OUTPUT  ${DUMMY_SOURCE}
    COMMAND cmake -E touch ${DUMMY_SOURCE}
    DEPENDS ${ARG_SRCS}
  )

  add_custom_command(
    OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${FIL_WE}.pb.cc"
           "${CMAKE_CURRENT_BINARY_DIR}/${FIL_WE}.pb.h"
    COMMAND  ${PROTOBUF_PROTOC_EXECUTABLE}
    ARGS --cpp_out  ${CMAKE_BINARY_DIR} -I
      ${CMAKE_BINARY_DIR} ${REWRITTEN_PROTO}
    DEPENDS ${REWRITTEN_PROTO}
    COMMENT "Running C++ protocol buffer compiler on ${FIL}"
    VERBATIM
  )

  # Just a dummy library, we will overwrite its output directly after again
  # with its POST_BUILD step.
  ug_library(${NAME}
    SRCS ${DUMMY_SOURCE}
    DEPENDS ${ARG_SRCS}
  )

  get_property(OUTPUT_FILE TARGET ${NAME} PROPERTY LOCATION)

  # We will delete the static lib generated by the last call to
  # 'ug_library' and recreate it using a GNU ar script that combines the
  # SRCS into the NAME.
  # TODO(hrapp): this is probably not very portable, but should work fine on
  # Linux.
  set(AR_SCRIPT "")
  set(AR_SCRIPT "CREATE ${OUTPUT_FILE}\n")
  foreach(SRC ${ARG_SRCS})
    get_property(STATIC_LIBRARY_FILE TARGET ${SRC} PROPERTY LOCATION)
    set(AR_SCRIPT "${AR_SCRIPT}ADDLIB ${STATIC_LIBRARY_FILE}\n")
  endforeach()
  set(AR_SCRIPT "${AR_SCRIPT}SAVE\nEND\n")
  set(AR_SCRIPT_FILE "${CMAKE_CURRENT_BINARY_DIR}/${NAME}_ar.script")
  file(WRITE ${AR_SCRIPT_FILE} ${AR_SCRIPT})

  add_custom_command(TARGET ${NAME} POST_BUILD
    COMMAND rm ${OUTPUT_FILE}
    COMMAND ${CMAKE_AR}
    ARGS -M < ${AR_SCRIPT_FILE}
    COMMENT "Recombining static libraries into ${NAME}."
  )
endfunction()

# Create a variable 'VAR_NAME'='FLAG'. If VAR_NAME is already set, FLAG is
# appended.
function(ug_add_flag VAR_NAME FLAG)
  if (${VAR_NAME})
    set(${VAR_NAME} "${${VAR_NAME}} ${FLAG}" PARENT_SCOPE)
  else()
    set(${VAR_NAME} "${FLAG}" PARENT_SCOPE)
  endif()
endfunction()

function(ug_test NAME)
  if (ENABLE_TEST STREQUAL "enable")
    _parse_arguments("${ARGN}")

    add_executable(${NAME}
      ${ARG_SRCS} ${ARG_HDRS}
    )
    find_package(GTest REQUIRED)
    _common_compile_stuff("PRIVATE")

    # Make sure that gmock always includes the correct gtest/gtest.h.
    # target_include_directories("${NAME}" SYSTEM PRIVATE
    #   "${GMOCK_SRC_DIR}/gtest/include")
    # target_link_libraries("${NAME}" gmock_main)
    target_include_directories("${NAME}" SYSTEM PRIVATE "${GTEST_INCLUDE_DIR}")
    target_link_libraries("${NAME}" ${GTEST_LIBRARIES} gmock_main)

    add_test(${NAME} ${NAME})
  endif()
endfunction()

function(ug_library NAME)
  _parse_arguments("${ARGN}")

  add_library(${NAME} 
    SHARED
    ${ARG_SRCS} ${ARG_HDRS}
  )

  # Update the global variable that contains all static libraries.
  SET(ALL_LIBRARIES "${ALL_LIBRARIES};${NAME}" CACHE INTERNAL "ALL_LIBRARIES")

  # This is needed for header only libraries. While they do not really mean
  # anything for cmake, they are useful to make dependencies explicit.
  set_target_properties(${NAME} PROPERTIES LINKER_LANGUAGE CXX)

  _common_compile_stuff("PUBLIC")
endfunction()

function(ug_binary NAME)
  _parse_arguments("${ARGN}")

  add_executable(${NAME} ${ARG_SRCS})

  _common_compile_stuff("PRIVATE")

  install(TARGETS "${NAME}" RUNTIME DESTINATION bin)
endfunction()



function(ug_proto_library NAME)
  _parse_arguments("${ARGN}")

  set(PROTO_SRCS)
  set(PROTO_HDRS)
  foreach(FIL ${ARG_SRCS})
    file(GLOB ABS_FIL ${FIL})
    file(RELATIVE_PATH REL_FIL ${PROJECT_SOURCE_DIR} ${ABS_FIL})
    # message("RELATIVE_PATH = " ${RELATIVE_PATH})
    get_filename_component(DIR ${REL_FIL} DIRECTORY)
    get_filename_component(FIL_WE ${REL_FIL} NAME_WE)
    set(TEMP_SRC "${PROJECT_BINARY_DIR}/${DIR}/${FIL_WE}.pb.cc")
    set(TEMP_HDR "${PROJECT_BINARY_DIR}/${DIR}/${FIL_WE}.pb.h")
    # message("TEMP_SRC = " ${TEMP_SRC})
    # message("TEMP_HDR = " ${TEMP_HDR})
    list(APPEND PROTO_SRCS ${TEMP_SRC})
    list(APPEND PROTO_HDRS ${TEMP_HDR})

    add_custom_command (
            OUTPUT ${TEMP_SRC} ${TEMP_HDR}

            COMMAND ${PROTOBUF_PROTOC_EXECUTABLE}
            ARGS --cpp_out ${PROJECT_BINARY_DIR} -I
            ${PROJECT_SOURCE_DIR} ${ABS_FIL}
            DEPENDS ${ABS_FIL}
            COMMENT "Running C++ protocol buffer compiler on ${ABS_FIL}"
            VERBATIM
    )
  endforeach()
  set_source_files_properties(${PROTO_SRCS} ${PROTO_HDRS}
    PROPERTIES GENERATED TRUE)

  ug_library("${NAME}"
      SRCS "${PROTO_SRCS}"
      HDRS "${PROTO_HDRS}"
      DEPENDS "${ARG_DEPENDS}"
  )

  target_include_directories("${NAME}" SYSTEM "PUBLIC"
    "${PROTOBUF_INCLUDE_DIR}")
  # TODO(hrapp): This should not explicityly list pthread and use
  # PROTOBUF_LIBRARIES, but that failed on first try.
  target_link_libraries("${NAME}" "${PROTOBUF_LIBRARY}" pthread)
endfunction()


macro(ug_initialize)

  set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH}
      ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
  set(GOOG_CXX_FLAGS "-pthread -std=c++14 -fPIC ${GOOG_CXX_FLAGS}")

  ug_add_flag(GOOG_CXX_FLAGS "-Wall")
  ug_add_flag(GOOG_CXX_FLAGS "-Wpedantic")
  ug_add_flag(GOOG_CXX_FLAGS "-march=native")

  # Turn some warnings into errors.
  ug_add_flag(GOOG_CXX_FLAGS "-Werror=format-security")
  ug_add_flag(GOOG_CXX_FLAGS "-Werror=missing-braces")
  ug_add_flag(GOOG_CXX_FLAGS "-Werror=reorder")
  ug_add_flag(GOOG_CXX_FLAGS "-Werror=return-type")
  ug_add_flag(GOOG_CXX_FLAGS "-Werror=switch")
  ug_add_flag(GOOG_CXX_FLAGS "-Werror=uninitialized")

  if(NOT CMAKE_BUILD_TYPE OR CMAKE_BUILD_TYPE STREQUAL "")
    set(CMAKE_BUILD_TYPE Release)
  endif()

  if(CMAKE_BUILD_TYPE STREQUAL "Release")
    ug_add_flag(GOOG_CXX_FLAGS "-O3 -DNDEBUG")
  elseif(CMAKE_BUILD_TYPE STREQUAL "RelWithDebInfo")
    ug_add_flag(GOOG_CXX_FLAGS "-O3 -g -DNDEBUG")
  elseif(CMAKE_BUILD_TYPE STREQUAL "Debug")
    if(FORCE_DEBUG_BUILD)
      message(WARNING "Building in Debug mode, expect very slow performance.")
      ug_add_flag(GOOG_CXX_FLAGS "-g")
    else()
      message(FATAL_ERROR
        "Compiling in Debug mode is not supported and can cause severely degraded performance. "
        "You should change the build type to Release. If you want to build in Debug mode anyway, "
        "call CMake with -DFORCE_DEBUG_BUILD=True"
      )
    endif()
  # Support for Debian packaging CMAKE_BUILD_TYPE
  elseif(CMAKE_BUILD_TYPE STREQUAL "None")
    message(WARNING "Building with CMAKE_BUILD_TYPE None, "
        "please make sure you have set CFLAGS and CXXFLAGS according to your needs.")
  else()
    message(FATAL_ERROR "Unknown CMAKE_BUILD_TYPE: ${CMAKE_BUILD_TYPE}")
  endif()

  message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")

  # Add a hook that reruns CMake when source files are added or removed.
  set(LIST_FILES_CMD "find ${PROJECT_SOURCE_DIR}/ -not -iwholename '*.git*' | sort | sed 's/^/#/'")
  set(FILES_LIST_PATH "${PROJECT_BINARY_DIR}/AllFiles.cmake")
  set(DETECT_CHANGES_CMD "bash" "-c" "${LIST_FILES_CMD} | diff -N -q ${FILES_LIST_PATH} - || ${LIST_FILES_CMD} > ${FILES_LIST_PATH}")
  add_custom_target(${PROJECT_NAME}_detect_changes ALL
    COMMAND ${DETECT_CHANGES_CMD}
    VERBATIM
  )
  if(NOT EXISTS ${FILES_LIST_PATH})
    execute_process(COMMAND ${DETECT_CHANGES_CMD})
  endif()
  include(${FILES_LIST_PATH})
endmacro()

macro(ug_enable_testing)
  set(ENABLE_TEST "enable")
  find_package(GMock REQUIRED)
endmacro()

macro(ug_enable_protobuf)
  find_package(Protobuf REQUIRED)
endmacro()

macro(ug_enable_pcl)
  find_package(PCL REQUIRED)
  add_definitions(${PCL_DEFINITIONS})
  include_directories(${PCL_INCLUDE_DIRS})
endmacro()

macro(ug_enable_opencv)
  find_package(OpenCV REQUIRED)
endmacro()

macro(ug_enable_boost)
  find_package(Boost REQUIRED)
  include_directories(${Boost_INCLUDE_DIR})
endmacro()

macro(ug_enable_eigen)
  find_package(Eigen3 REQUIRED)
endmacro()

macro(ug_enable_pangolin)
  find_package(Pangolin  REQUIRED)
  include_directories(${Pangolin_INCLUDE_DIRS})
endmacro()

macro(ug_enable_g2o)
  find_package(G2O REQUIRED)
  include_directories(${G2O_INCLUDE_DIRS})
endmacro()

macro(ug_enable_openmp)
  find_package(OpenMP REQUIRED)
endmacro()

macro(ug_enable_gtsam)

endmacro()

macro(ug_enable_yaml)
  find_package(PkgConfig REQUIRED)
  pkg_check_modules(YAML_CPP REQUIRED yaml-cpp)
  include_directories(${YAML_CPP_INCLUDEDIR})
endmacro()

macro(ug_enable_fastrtps)

  include_directories("/usr/local/fast-rtps/include")

endmacro()




