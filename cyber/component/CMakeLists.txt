ug_library(
    cyber_component
    HDRS component.h
    DEPENDS 
        cyber_component_component_base
        cyber_scheduler
    
)


ug_library(
    cyber_component_timer_component
    USES_FASTRTPS
    SRCS timer_component.cc
    HDRS timer_component.h
    DEPENDS 
        cyber_component_component_base
        cyber_blocker_manager
        cyber_timer
        cyber_transport_history
        cyber_transport_hybrid_transmitter
        cyber_transport_intra_transmitter
        cyber_transport_rtps_transmitter
        cyber_transport_shm_transmitter
    
)

ug_library(
    cyber_component_component_base
    HDRS component_base.h
    DEPENDS 
        cyber_base_signal
        cyber_base_thread_pool
        cyber_class_loader
        cyber_node
    
)

