ug_library(
    cyber_logger
    SRCS logger.cc
    HDRS logger.h
    DEPENDS 
        cyber_common
        cyber_logger_log_file_object
    
)


ug_library(
    cyber_logger_async_logger
    SRCS async_logger.cc
    HDRS async_logger.h
    DEPENDS 
        cyber_base_macros
        cyber_common
        cyber_logger_log_file_object
    
)


ug_library(
    cyber_logger_log_file_object
    SRCS log_file_object.cc
    HDRS log_file_object.h
    DEPENDS 
        cyber_binary
        cyber_common_log
        cyber_logger_logger_util
    
)

ug_library(
    cyber_logger_logger_util
    SRCS logger_util.cc
    HDRS logger_util.h
    DEPENDS 
        cyber_common_global_data
    
)
