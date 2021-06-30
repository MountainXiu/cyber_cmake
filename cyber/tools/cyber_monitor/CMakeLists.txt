file(GLOB srcs (*.cc))
file(GLOB hdrs (*.h))

ug_binary(cyber_monitor
  USES_GLOG
  USES_FASTRTPS
  USES_FASTCDR
  SRCS ${srcs}
  HDRS ${hdrs}
  DEPENDS
    cyber_init
    cyber_core
    cyber_service_discovery_topology_manager
    cyber_message_raw_message
    cyber_record_record_message
    ncurses
)