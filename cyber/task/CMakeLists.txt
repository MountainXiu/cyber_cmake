ug_library(
    cyber_task
    HDRS task.h
    DEPENDS
        cyber_task_task_manager
)


ug_library(
    cyber_task_task_manager
    SRCS task_manager.cc
    HDRS task_manager.h

    DEPENDS
        cyber_scheduler_scheduler_factory
)