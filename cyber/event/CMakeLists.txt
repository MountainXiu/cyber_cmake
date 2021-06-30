ug_library(
    cyber_event_perf_event_cache
    SRCS perf_event_cache.cc
    HDRS perf_event_cache.h
    DEPENDS 
        cyber_event_perf_event
        cyber_state
        cyber_base_bounded_queue
        cyber_common_global_data
        cyber_common_log
        cyber_common_macros
        cyber_time

)

ug_library(
    cyber_event_perf_event
    HDRS perf_event.h
    DEPENDS 
        cyber_common_global_data

)

