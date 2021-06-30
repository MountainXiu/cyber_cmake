ug_library(
    cyber_node
    USES_FASTRTPS
    SRCS node.cc
    HDRS node.h
    DEPENDS 
        cyber_node_node_channel_impl
        cyber_node_node_service_impl
    
)

ug_library(
    cyber_node_node_channel_impl
    HDRS node_channel_impl.h
    DEPENDS 
        cyber_node_reader
        cyber_node_writer
        cyber_blocker_intra_reader
        cyber_blocker_intra_writer
        cyber_common_global_data
        cyber_message_message_traits
        cyber_proto
    
)

ug_library(
    cyber_node_node_service_impl
    HDRS node_service_impl.h
    DEPENDS 
        cyber_node_reader
        cyber_node_writer
        cyber_common_global_data
        cyber_service
        cyber_service_client
        cyber_service_discovery_topology_manager
    
)


ug_library(
    cyber_node_reader
    HDRS reader.h
    DEPENDS 
        cyber_node_reader_base
        cyber_blocker
        cyber_common_global_data
        cyber_croutine_routine_factory
        cyber_data_data_visitor
        cyber_proto
        cyber_scheduler
        cyber_service_discovery_topology_manager
        cyber_time
        cyber_transport
    
)

ug_library(
    cyber_node_reader_base
    HDRS reader_base.h
    DEPENDS 
        cyber_event_perf_event_cache
        cyber_transport
    
)


ug_library(
    cyber_node_writer
    HDRS writer.h
    DEPENDS 
        cyber_node_writer_base
        cyber_common_log
        cyber_proto
        cyber_service_discovery_topology_manager
        cyber_transport
    
)

ug_library(
    cyber_node_writer_base
    HDRS writer_base.h
    DEPENDS 
        cyber_common_macros
        cyber_common_util
        cyber_proto
    
)


