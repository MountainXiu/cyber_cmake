
ug_library(
    cyber_service_client
    HDRS client.h
    DEPENDS 
        cyber_service_client_base
)

ug_library(
    cyber_service_client_base
    HDRS client_base.h
)

ug_library(
    cyber_service
    HDRS service.h
    DEPENDS 
        cyber_service_service_base
        cyber_scheduler
)

ug_library(
    cyber_service_service_base
    HDRS service_base.h
)

