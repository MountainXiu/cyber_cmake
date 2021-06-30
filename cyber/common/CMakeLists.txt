ug_library (
    cyber_common
    DEPENDS
    cyber_common_environment
    cyber_common_file
    cyber_common_global_data
    cyber_common_log
    cyber_common_macros
    cyber_common_time_conversion
    cyber_common_types
    cyber_common_util

)

ug_library (
    cyber_common_file
    SRCS file.cc
    HDRS file.h
    USES_GLOG
    DEPENDS
        cyber_common_log
)


ug_library (cyber_common_log
    USES_GLOG
    HDRS log.h
    DEPENDS
        cyber_binary
)



ug_library (
    cyber_common_environment
    HDRS  environment.h
    DEPENDS
        cyber_common_log

)


ug_library (
    cyber_common_global_data
    SRCS global_data.cc
    HDRS global_data.h

    DEPENDS
        cyber_base_atomic_hash_map
        cyber_base_atomic_rw_lock
        cyber_common_environment
        cyber_common_file
        cyber_common_macros
        cyber_common_util
        cyber_proto
)


ug_library (
  cyber_common_macros
    HDRS  macros.h
    DEPENDS
    cyber_base_macros

)

ug_library (
  cyber_common_time_conversion
    HDRS  time_conversion.h
)

ug_library (
  cyber_common_types
    HDRS  types.h
)

ug_library (
  cyber_common_util
    HDRS  util.h
)

ug_test(cyber_common_log_test
  USES_GLOG
  SRCS log_test.cc
  DEPENDS
    cyber_common_log
)