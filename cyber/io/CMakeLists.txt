ug_library(
    cyber_io
    DEPENDS 
        cyber_io_poll_data
        cyber_io_poll_handler
        cyber_io_poller
        cyber_io_session
    
)

ug_library(
    cyber_io_poll_data
    HDRS poll_data.h
)

ug_library(
    cyber_io_poll_handler
    SRCS poll_handler.cc
    HDRS poll_handler.h
    DEPENDS 
        cyber_io_poll_data
        cyber_io_poller
        cyber_common_log
        cyber_croutine
    
)

ug_library(
    cyber_io_poller
    SRCS poller.cc
    HDRS poller.h
    DEPENDS 
        cyber_io_poll_data
        cyber_base_atomic_rw_lock
        cyber_common_log
        cyber_common_macros
        cyber_scheduler_scheduler_factory
        cyber_time
    
)

ug_library(
    cyber_io_session
    SRCS session.cc
    HDRS session.h
    DEPENDS 
        cyber_io_poll_handler
        cyber_common_log
    
)
