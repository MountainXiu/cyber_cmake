ug_library(
    cyber_data
    DEPENDS 
        cyber_data_all_latest
        cyber_data_cache_buffer
        cyber_data_channel_buffer
        cyber_data_data_dispatcher
        cyber_data_data_fusion
        cyber_data_data_notifier
        cyber_data_data_visitor
        cyber_data_data_visitor_base
    
)

ug_library(
    cyber_data_cache_buffer
    SRCS cache_buffer.h
)

ug_library(
    cyber_data_channel_buffer
    HDRS channel_buffer.h
    DEPENDS 
        cyber_data_data_notifier
        cyber_proto
    
)

ug_library(
    cyber_data_data_dispatcher
    HDRS data_dispatcher.h
    DEPENDS 
        cyber_data_channel_buffer
    
)

ug_library(
    cyber_data_data_visitor
    HDRS data_visitor.h
)

ug_library(
    cyber_data_data_visitor_base
    HDRS data_visitor_base.h
)

ug_library(
    cyber_data_data_notifier
    HDRS data_notifier.h
    DEPENDS 
        cyber_data_cache_buffer
    
)

ug_library(
    cyber_data_data_fusion
    HDRS fusion/data_fusion.h
)

ug_library(
    cyber_data_all_latest
    HDRS fusion/all_latest.h
    DEPENDS 
        cyber_data_channel_buffer
        cyber_data_data_fusion
    
)



