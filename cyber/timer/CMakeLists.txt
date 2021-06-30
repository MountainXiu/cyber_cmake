
ug_library(
    cyber_timer
    SRCS timer.cc
    HDRS timer.h
    DEPENDS 
        cyber_timer_timing_wheel
        cyber_common_global_data

)

ug_library(
    cyber_timer_timer_task
    HDRS timer_task.h
)

ug_library(
    cyber_timer_timer_bucket
    HDRS timer_bucket.h
    DEPENDS 
        cyber_timer_timer_task

)

ug_library(
    cyber_timer_timing_wheel
    SRCS timing_wheel.cc
    HDRS timing_wheel.h
    DEPENDS 
        cyber_timer_timer_bucket
        cyber_task
        cyber_time
        cyber_time_duration
        cyber_time_rate

)

