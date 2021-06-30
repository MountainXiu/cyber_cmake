file(GLOB ALL_PROTOS "*.proto")
ug_proto_library(cyber_proto
        SRCS
        ${ALL_PROTOS}
)