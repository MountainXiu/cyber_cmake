ug_library(
    cyber_parameter_parameter
    SRCS parameter.cc
    HDRS parameter.h
    DEPENDS 
        cyber_message_protobuf_factory
        cyber_proto
)

ug_library(
    cyber_parameter_parameter_client
    USES_FASTRTPS
    SRCS parameter_client.cc
    HDRS parameter_client.h
    DEPENDS 
        cyber_parameter_parameter
        cyber_parameter_parameter_service_names
        cyber_node
        cyber_service_client

)

ug_library(
    cyber_parameter_parameter_server
    USES_FASTRTPS
    SRCS parameter_server.cc
    HDRS parameter_server.h
    DEPENDS 
        cyber_parameter_parameter
        cyber_parameter_parameter_service_names
        cyber_node
        cyber_service

)

ug_library(
    cyber_parameter_parameter_service_names
    HDRS parameter_service_names.h
)

