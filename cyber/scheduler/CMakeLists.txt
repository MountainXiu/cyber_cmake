ug_library(
    cyber_scheduler_processor
    SRCS processor.cc
    HDRS processor.h
    DEPENDS 
        cyber_data
        cyber_scheduler_processor_context
    
)

ug_library(
    cyber_scheduler_processor_context
    SRCS processor_context.cc
    HDRS processor_context.h
    DEPENDS 
        cyber_croutine
        cyber_data
    
)

ug_library(
    cyber_scheduler
    SRCS scheduler.cc
    HDRS scheduler.h
    DEPENDS 
        cyber_croutine
        cyber_scheduler_mutex_wrapper
        cyber_scheduler_pin_thread
        cyber_scheduler_processor
    
)

ug_library(
    cyber_scheduler_mutex_wrapper
    HDRS common/mutex_wrapper.h
)

ug_library(
    cyber_scheduler_cv_wrapper
    HDRS common/cv_wrapper.h
)

ug_library(
    cyber_scheduler_pin_thread
    SRCS common/pin_thread.cc
    HDRS common/pin_thread.h
    DEPENDS 
        cyber_common_log
    
)

ug_library(
    cyber_scheduler_scheduler_factory
    SRCS scheduler_factory.cc
    HDRS scheduler_factory.h
    DEPENDS 
        cyber_proto
        cyber_scheduler_scheduler_choreography
        cyber_scheduler_scheduler_classic
    
)

ug_library(
    cyber_scheduler_scheduler_choreography
    SRCS policy/scheduler_choreography.cc
    HDRS policy/scheduler_choreography.h
    DEPENDS 
        cyber_scheduler
        cyber_scheduler_choreography_context
        cyber_scheduler_classic_context
    
)

ug_library(
    cyber_scheduler_scheduler_classic
    SRCS policy/scheduler_classic.cc
    HDRS policy/scheduler_classic.h
    DEPENDS 
        cyber_scheduler
        cyber_scheduler_classic_context
    
)

ug_library(
    cyber_scheduler_choreography_context
    SRCS policy/choreography_context.cc
    HDRS policy/choreography_context.h
    DEPENDS 
        cyber_croutine
        cyber_proto
        cyber_scheduler_processor
    
)

ug_library(
    cyber_scheduler_classic_context
    SRCS policy/classic_context.cc
    HDRS policy/classic_context.h
    DEPENDS 
        cyber_croutine
        cyber_proto
        cyber_scheduler_cv_wrapper
        cyber_scheduler_mutex_wrapper
        cyber_scheduler_processor
    
)
