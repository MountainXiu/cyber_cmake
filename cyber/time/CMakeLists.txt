ug_library(
    cyber_time
    SRCS time.cc
    HDRS time.h
    DEPENDS 
        cyber_time_duration
    
)


ug_library(
    cyber_time_rate
    SRCS rate.cc
    HDRS rate.h
    DEPENDS 
        cyber_time_duration
        cyber_time
        cyber_common_log
    
)

ug_library(
    cyber_time_duration
    SRCS duration.cc
    HDRS duration.h
)


ug_library(
    cyber_time_clock
    SRCS clock.cc
    HDRS clock.h
    DEPENDS 
        cyber_time
        cyber_base_atomic_rw_lock
        cyber_common_global_data
        cyber_common_log
        cyber_common_macros
        cyber_common_util
        cyber_proto
)
