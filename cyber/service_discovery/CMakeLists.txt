ug_library(
    cyber_service_discovery_topology_manager
    SRCS topology_manager.cc
    HDRS topology_manager.h
    DEPENDS 
        cyber_service_discovery_channel_manager
        cyber_service_discovery_node_manager
        cyber_service_discovery_participant_listener
        cyber_service_discovery_service_manager
        cyber_transport_participant
    
)

ug_library(
    cyber_service_discovery_participant_listener
    USES_FASTRTPS
    SRCS communication/participant_listener.cc
    HDRS communication/participant_listener.h
    DEPENDS 
        cyber_common_log

    
)

ug_library(
    cyber_service_discovery_subscriber_listener
    USES_FASTRTPS
    SRCS communication/subscriber_listener.cc
    HDRS communication/subscriber_listener.h
    DEPENDS 
        cyber_common_log
        cyber_transport_underlay_message
        cyber_transport_underlay_message_type
    
)

ug_library(
    cyber_service_discovery_graph
    SRCS container/graph.cc
    HDRS container/graph.h
    DEPENDS cyber_base_atomic_rw_lock
)

ug_library(
    cyber_service_discovery_multi_value_warehouse
    SRCS container/multi_value_warehouse.cc
    HDRS container/multi_value_warehouse.h
    DEPENDS 
        cyber_service_discovery_warehouse_base
        cyber_base_atomic_rw_lock
    
)

ug_library(
    cyber_service_discovery_single_value_warehouse
    SRCS container/single_value_warehouse.cc
    HDRS container/single_value_warehouse.h
    DEPENDS 
        cyber_service_discovery_warehouse_base
        cyber_base_atomic_rw_lock
    
)

ug_library(
    cyber_service_discovery_warehouse_base
    HDRS container/warehouse_base.h
    DEPENDS cyber_service_discovery_role
)

ug_library(
    cyber_service_discovery_role
    SRCS role/role.cc
    HDRS role/role.h
    DEPENDS 
        cyber_binary
        cyber_common_log
        cyber_common_types
        cyber_proto
    
)

ug_library(
    cyber_service_discovery_manager
    SRCS specific_manager/manager.cc
    HDRS specific_manager/manager.h
    DEPENDS 
        cyber_service_discovery_subscriber_listener
        cyber_state
        cyber_base_signal
        cyber_message_message_traits
        cyber_message_protobuf_factory
        cyber_proto
        cyber_time
        cyber_transport_attributes_filler
        cyber_transport_qos_profile_conf
        cyber_transport_underlay_message_type
    
)

ug_library(
    cyber_service_discovery_channel_manager
    SRCS specific_manager/channel_manager.cc
    HDRS specific_manager/channel_manager.h
    DEPENDS 
        cyber_service_discovery_graph
        cyber_service_discovery_manager
        cyber_service_discovery_multi_value_warehouse
        cyber_service_discovery_single_value_warehouse
    
)

ug_library(
    cyber_service_discovery_node_manager
    SRCS specific_manager/node_manager.cc
    HDRS specific_manager/node_manager.h
    DEPENDS 
        cyber_service_discovery_manager
        cyber_service_discovery_multi_value_warehouse
        cyber_service_discovery_single_value_warehouse
    
)


ug_library(
    cyber_service_discovery_service_manager
    SRCS specific_manager/service_manager.cc
    HDRS specific_manager/service_manager.h
    DEPENDS 
        cyber_service_discovery_manager
        cyber_service_discovery_multi_value_warehouse
        cyber_service_discovery_single_value_warehouse
    
)
