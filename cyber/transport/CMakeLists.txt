
ug_library(
    cyber_transport

    USES_FASTRTPS
    USES_FASTCDR
    SRCS transport.cc
    HDRS transport.h

    DEPENDS 
        cyber_transport_attributes_filler
        cyber_transport_history
        cyber_transport_hybrid_receiver
        cyber_transport_hybrid_transmitter
        cyber_transport_intra_dispatcher
        cyber_transport_intra_receiver
        cyber_transport_intra_transmitter
        cyber_transport_participant
        cyber_transport_qos_profile_conf
        cyber_transport_rtps_dispatcher
        cyber_transport_rtps_receiver
        cyber_transport_rtps_transmitter
        cyber_transport_shm_dispatcher
        cyber_transport_shm_receiver
        cyber_transport_shm_transmitter
        cyber_transport_sub_listener
        cyber_transport_underlay_message
        cyber_transport_underlay_message_type
        cyber_service_discovery_role
        cyber_task  
)


ug_library(
    cyber_transport_endpoint
    SRCS common/endpoint.cc
    HDRS common/endpoint.h
    DEPENDS 
        cyber_transport_identity
        cyber_common_global_data
        cyber_proto
)


ug_library(
    cyber_transport_identity
    SRCS common/identity.cc
    HDRS common/identity.h
    DEPENDS 
        cyber_common_util
        rt
        uuid
)



ug_library(
    cyber_transport_dispatcher
    SRCS dispatcher/dispatcher.cc
    HDRS dispatcher/dispatcher.h
    
    DEPENDS 
        cyber_transport_listener_handler
        cyber_transport_message_info
        cyber_message_message_traits
        cyber_proto
    
)

ug_library(
    cyber_transport_intra_dispatcher
    SRCS dispatcher/intra_dispatcher.cc
    HDRS dispatcher/intra_dispatcher.h
    DEPENDS 
        cyber_transport_dispatcher
        cyber_message_message_traits
        cyber_proto
    
)

ug_library(
    cyber_transport_rtps_dispatcher
    SRCS dispatcher/rtps_dispatcher.cc
    HDRS dispatcher/rtps_dispatcher.h
    DEPENDS 
        cyber_transport_attributes_filler
        cyber_transport_dispatcher
        cyber_transport_participant
        cyber_transport_sub_listener
        cyber_message_message_traits
        cyber_proto
    
)

ug_library(
    cyber_transport_shm_dispatcher
    SRCS dispatcher/shm_dispatcher.cc
    HDRS dispatcher/shm_dispatcher.h
    DEPENDS 
        cyber_transport_dispatcher
        cyber_transport_notifier_factory
        cyber_transport_readable_info
        cyber_transport_segment_factory
        cyber_message_message_traits
        cyber_proto
        cyber_scheduler_scheduler_factory
        rt
)

ug_library(
    cyber_transport_history_attributes
    HDRS message/history_attributes.h
)

ug_library(
    cyber_transport_history
    HDRS message/history.h
    DEPENDS 
        cyber_transport_history_attributes
    
)

ug_library(
    cyber_transport_listener_handler
    HDRS message/listener_handler.h
)

ug_library(
    cyber_transport_message_info
    SRCS message/message_info.cc
    HDRS message/message_info.h
    DEPENDS 
        cyber_base_signal
        cyber_common
        cyber_message_raw_message
        cyber_transport_identity
    
)

ug_library(
    cyber_transport_qos_profile_conf
    SRCS qos/qos_profile_conf.cc
    HDRS qos/qos_profile_conf.h
    DEPENDS 
        cyber_transport_history
        cyber_proto
    
)

ug_library(
    cyber_transport_hybrid_receiver
    HDRS receiver/hybrid_receiver.h
    DEPENDS 
        cyber_transport_receiver
    
)

ug_library(
    cyber_transport_intra_receiver
    HDRS receiver/intra_receiver.h
    DEPENDS 
        cyber_transport_receiver
    
)

ug_library(
    cyber_transport_receiver
    HDRS receiver/receiver.h
    DEPENDS 
        cyber_transport_endpoint
        cyber_transport_history
        cyber_transport_message_info
    
)

ug_library(
    cyber_transport_rtps_receiver
    HDRS receiver/rtps_receiver.h
    DEPENDS 
        cyber_transport_receiver
    
)

ug_library(
    cyber_transport_shm_receiver
    HDRS receiver/shm_receiver.h
    DEPENDS 
        cyber_transport_readable_info
        cyber_transport_receiver
        rt
)

ug_library(
    cyber_transport_attributes_filler
    USES_FASTRTPS
    SRCS rtps/attributes_filler.cc
    HDRS rtps/attributes_filler.h
    DEPENDS 
        cyber_transport_qos_profile_conf
        cyber_common_log
)

ug_library(
    cyber_transport_underlay_message
    USES_FASTCDR
    SRCS rtps/underlay_message.cc
    HDRS rtps/underlay_message.h
    DEPENDS 
        cyber_common_log
)

ug_library(
    cyber_transport_participant
    SRCS rtps/participant.cc
    HDRS rtps/participant.h
    DEPENDS 
        cyber_transport_underlay_message
        cyber_transport_underlay_message_type
        cyber_common_global_data
    
)

ug_library(
    cyber_transport_sub_listener
    SRCS rtps/sub_listener.cc
    HDRS rtps/sub_listener.h
    DEPENDS 
        cyber_transport_message_info
        cyber_transport_underlay_message
        cyber_transport_underlay_message_type
    
)

ug_library(
    cyber_transport_underlay_message_type
    USES_FASTRTPS
    USES_FASTCDR
    SRCS rtps/underlay_message_type.cc
    HDRS rtps/underlay_message_type.h
    DEPENDS 
        cyber_transport_underlay_message   
)


ug_library(
    cyber_transport_block
    SRCS shm/block.cc
    HDRS shm/block.h
    DEPENDS 
        cyber_base_atomic_rw_lock
        cyber_common_log
    
)

ug_library(
    cyber_transport_condition_notifier
    SRCS shm/condition_notifier.cc
    HDRS shm/condition_notifier.h
    DEPENDS 
        cyber_transport_notifier_base
        cyber_common_global_data
        cyber_common_log
        cyber_common_util
    
)

ug_library(
    cyber_transport_multicast_notifier
    SRCS shm/multicast_notifier.cc
    HDRS shm/multicast_notifier.h
    DEPENDS 
        cyber_transport_notifier_base
        cyber_common_global_data
        cyber_common_log
        cyber_common_macros
    
)

ug_library(
    cyber_transport_notifier_base
    HDRS shm/notifier_base.h
    DEPENDS 
        cyber_transport_readable_info
    
)

ug_library(
    cyber_transport_notifier_factory
    SRCS shm/notifier_factory.cc
    HDRS shm/notifier_factory.h
    DEPENDS 
        cyber_transport_condition_notifier
        cyber_transport_multicast_notifier
        cyber_transport_notifier_base
        cyber_common_global_data
        cyber_common_log
    
)

ug_library(
    cyber_transport_readable_info
    SRCS shm/readable_info.cc
    HDRS shm/readable_info.h
    DEPENDS 
        cyber_common_log
    
)

ug_library(
    cyber_transport_xsi_segment
    SRCS shm/xsi_segment.cc
    HDRS shm/xsi_segment.h
    DEPENDS 
        cyber_transport_segment
        cyber_common_log
        cyber_common_util
    
)

ug_library(
    cyber_transport_posix_segment
    SRCS shm/posix_segment.cc
    HDRS shm/posix_segment.h
    DEPENDS 
        cyber_transport_segment
        cyber_common_log
        cyber_common_util
    
)

ug_library(
    cyber_transport_segment
    SRCS shm/segment.cc
    HDRS shm/segment.h
    DEPENDS 
        cyber_transport_block
        cyber_transport_shm_conf
        cyber_transport_state
        cyber_common_log
        cyber_common_util
    
)

ug_library(
    cyber_transport_segment_factory
    SRCS shm/segment_factory.cc
    HDRS shm/segment_factory.h
    DEPENDS 
        cyber_transport_posix_segment
        cyber_transport_segment
        cyber_transport_xsi_segment
        cyber_common_global_data
        cyber_common_log
    
)

ug_library(
    cyber_transport_shm_conf
    SRCS shm/shm_conf.cc
    HDRS shm/shm_conf.h
    DEPENDS 
        cyber_common_log
        rt
    
)

ug_library(
    cyber_transport_state
    SRCS shm/state.cc
    HDRS shm/state.h
)

ug_library(
    cyber_transport_hybrid_transmitter
    HDRS transmitter/hybrid_transmitter.h
    DEPENDS 
        cyber_transport_transmitter
    
)

ug_library(
    cyber_transport_intra_transmitter
    HDRS transmitter/intra_transmitter.h
    DEPENDS 
        cyber_transport_transmitter
    
)

ug_library(
    cyber_transport_transmitter
    HDRS transmitter/transmitter.h
    DEPENDS 
        cyber_transport_endpoint
        cyber_transport_message_info
        cyber_event_perf_event_cache
    
)

ug_library(
    cyber_transport_rtps_transmitter
    HDRS transmitter/rtps_transmitter.h
    DEPENDS 
        cyber_transport_transmitter
    
)

ug_library(
    cyber_transport_shm_transmitter
    HDRS transmitter/shm_transmitter.h
    DEPENDS 
        cyber_transport_transmitter
        rt
)

# ug_test(
#     cyber_transport_transport_test
#     SRCS transport_test.cc
#     DEPENDS
#         cyber_core
#         cyber_proto
# )