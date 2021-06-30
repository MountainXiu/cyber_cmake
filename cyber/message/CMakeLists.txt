ug_library(
    cyber_message_message_header
    HDRS message_header.h
)

ug_library(
    cyber_message_message_traits
    HDRS message_traits.h
    DEPENDS 
        cyber_message_message_header
        cyber_message_protobuf_traits
        cyber_message_py_message_traits
        cyber_message_raw_message_traits
        cyber_base_macros
    
)

ug_library(
    cyber_message_protobuf_factory
    SRCS protobuf_factory.cc
    HDRS protobuf_factory.h
    DEPENDS 
        cyber_common_log
        cyber_common_macros
        cyber_proto
)

ug_library(
    cyber_message_protobuf_traits
    HDRS protobuf_traits.h
    DEPENDS 
        cyber_message_protobuf_factory
)

ug_library(
    cyber_message_py_message
    HDRS py_message.h
    DEPENDS 
        cyber_message_protobuf_factory
    
)

ug_library(
    cyber_message_py_message_traits
    HDRS py_message_traits.h
    DEPENDS 
        cyber_message_protobuf_factory
        cyber_message_py_message
)

ug_library(
    cyber_message_raw_message
    HDRS raw_message.h
    DEPENDS 
        cyber_message_protobuf_factory
)

ug_library(
    cyber_message_raw_message_traits
    HDRS raw_message_traits.h
    DEPENDS 
        cyber_message_protobuf_factory
        cyber_message_raw_message
)
