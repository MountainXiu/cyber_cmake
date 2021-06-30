add_subdirectory(proto)
add_subdirectory(base)
add_subdirectory(binary)
add_subdirectory(blocker)
add_subdirectory(class_loader)
add_subdirectory(common)
add_subdirectory(component)
add_subdirectory(croutine)
add_subdirectory(data)
add_subdirectory(event)
add_subdirectory(io)
add_subdirectory(logger)
add_subdirectory(message)
add_subdirectory(node)
add_subdirectory(parameter)
add_subdirectory(record)
add_subdirectory(scheduler)

add_subdirectory(service)
add_subdirectory(service_discovery)
add_subdirectory(sysmo)
add_subdirectory(task)
add_subdirectory(time)
add_subdirectory(timer)
add_subdirectory(transport)
add_subdirectory(tools/cyber_monitor)
add_subdirectory(tools/cyber_recorder)

# add_subdirectory(class_loader)

ug_library(cyber_state
  SRCS state.cc
  HDRS state.h
  DEPENDS 
    cyber_common
)

ug_library(cyber_init
  SRCS init.cc
  HDRS init.h
  DEPENDS
    cyber_binary
    cyber_state
    cyber_common_file
    cyber_logger_async_logger
    cyber_node
    cyber_proto
    cyber_sysmo
    cyber_time_clock
    cyber_timer_timing_wheel
)

ug_library(
    cyber_core
    USES_FASTRTPS
    USES_FASTCDR
    USES_GLOG

    SRCS cyber.cc
    HDRS cyber.h
    DEPENDS 
        cyber_binary
        cyber_init
        cyber_state
        cyber_base
        cyber_blocker_manager
        cyber_class_loader
        cyber_class_loader_manager
        cyber_common
        cyber_component
        cyber_component_timer_component
        cyber_croutine
        cyber_data
        cyber_event_perf_event_cache
        cyber_io
        cyber_logger
        cyber_logger_async_logger
        cyber_message_message_traits
        cyber_message_protobuf_traits
        cyber_message_py_message_traits
        cyber_message_raw_message_traits
        cyber_node
        cyber_parameter_parameter_client
        cyber_parameter_parameter_server
        cyber_proto
        cyber_record
        cyber_scheduler
        cyber_scheduler_scheduler_factory
        cyber_service
        cyber_service_client
        cyber_service_discovery_topology_manager
        cyber_sysmo
        cyber_task
        cyber_time
        cyber_time_clock
        cyber_time_duration
        cyber_time_rate
        cyber_timer
        cyber_transport
        cyber_transport_participant
        cyber_transport_sub_listener
        uuid
        rt
        protobuf
        PocoFoundation
        atomic
)

ug_binary(mainboard
  SRCS 
    mainboard/mainboard.cc
    mainboard/module_argument.cc
    mainboard/module_controller.cc
  HDRS
    mainboard/module_argument.h
    mainboard/module_controller.h
  DEPENDS
    cyber_core
    cyber_proto

)