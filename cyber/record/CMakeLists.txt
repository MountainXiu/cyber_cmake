file(GLOB_RECURSE srcs *.cc)
file(GLOB_RECURSE hdrs *.h)
file(GLOB_RECURSE tests "*_test.cc")
list(REMOVE_ITEM srcs ${tests})
ug_library(
    cyber_record
    SRCS ${srcs}
    HDRS ${hdrs}
    DEPENDS 
        cyber_record_record_reader
        cyber_record_record_viewer
        cyber_record_record_writer
    
)

ug_library(
    cyber_record_record_file_base
    SRCS file/record_file_base.cc
    HDRS file/record_file_base.h
    DEPENDS 
        cyber_common_log
        cyber_proto
    
)

ug_library(
    cyber_record_record_file_reader
    SRCS file/record_file_reader.cc
    HDRS file/record_file_reader.h
    DEPENDS 
        cyber_record_record_file_base
        cyber_record_section
        cyber_common_file
        cyber_time  
)

ug_library(
    cyber_record_record_file_writer
    SRCS file/record_file_writer.cc
    HDRS file/record_file_writer.h
    DEPENDS 
        cyber_record_record_file_base
        cyber_record_section
        cyber_common_file
        cyber_time
        protobuf
    
)

ug_library(
    cyber_record_section
    HDRS file/section.h
)

ug_library(
    cyber_record_header_builder
    SRCS header_builder.cc
    HDRS header_builder.h
    DEPENDS 
        cyber_proto
    
)

ug_library(
    cyber_record_record_base
    HDRS record_base.h
    DEPENDS 
        cyber_proto
    
)

ug_library(
    cyber_record_record_message
    HDRS record_message.h
)

ug_library(
    cyber_record_record_reader
    SRCS record_reader.cc
    HDRS record_reader.h
    DEPENDS 
        cyber_record_record_base
        cyber_record_record_file_reader
        cyber_record_record_message
    
)


ug_library(
    cyber_record_record_viewer
    SRCS record_viewer.cc
    HDRS record_viewer.h
    DEPENDS 
        cyber_record_record_message
        cyber_record_record_reader
    
)

ug_library(
    cyber_record_record_writer
    SRCS record_writer.cc
    HDRS record_writer.h
    DEPENDS 
        cyber_record_header_builder
        cyber_record_record_base
        cyber_record_record_file_writer
        cyber_message_message_traits
        cyber_message_raw_message
        cyber_proto
    
)
