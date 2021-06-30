ug_library(
    cyber_recorder_play_param
    HDRS play_param.h
)

ug_library(
    cyber_recorder_play_task
    USES_FASTRTPS
    SRCS play_task.cc
    HDRS play_task.h
    DEPENDS 
        cyber_common_log
        cyber_message_raw_message
        cyber_node_writer
    
)

ug_library(
    cyber_recorder_play_task_buffer
    SRCS play_task_buffer.cc
    HDRS play_task_buffer.h
    DEPENDS 
        cyber_recorder_play_task
    
)

ug_library(
    cyber_recorder_play_task_consumer
    SRCS play_task_consumer.cc
    HDRS play_task_consumer.h
    DEPENDS 
        cyber_recorder_play_task_buffer
        cyber_common_log
        cyber_time
    
)

ug_library(
    cyber_recorder_play_task_producer
    SRCS play_task_producer.cc
    HDRS play_task_producer.h
    DEPENDS 
        cyber_recorder_play_param
        cyber_recorder_play_task_buffer
        cyber_core
        cyber_common_log
        cyber_message_protobuf_factory
        cyber_message_raw_message
        cyber_node
        cyber_node_writer
        cyber_record_record_reader
        cyber_record_record_viewer
    
)

ug_library(
    cyber_recorder_player
    SRCS player.cc
    HDRS player.h
    DEPENDS 
        cyber_recorder_play_param
        cyber_recorder_play_task_buffer
        cyber_recorder_play_task_consumer
        cyber_recorder_play_task_producer
        cyber_init
    
)
