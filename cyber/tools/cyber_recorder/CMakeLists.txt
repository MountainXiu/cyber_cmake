file(GLOB_RECURSE srcs *.cc)
file(GLOB_RECURSE hdrs *.h)

ug_binary(
    cyber_recorder
    USES_GLOG
    USES_FASTRTPS
    SRCS ${srcs}
    HDRS ${hdrs}

    DEPENDS 
        cyber_init
        cyber_base_for_each
        cyber_common_file
        cyber_common_log
        cyber_common_time_conversion
        cyber_core
        cyber_proto
)
