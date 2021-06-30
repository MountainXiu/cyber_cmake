ug_library(cyber_blocker
  HDRS blocker.h
)

ug_library(cyber_blocker_manager
  HDRS blocker_manager.h
  SRCS blocker_manager.cc
  DEPENDS cyber_blocker
)

ug_library(cyber_blocker_intra_reader
  HDRS intra_reader.h
  DEPENDS cyber_blocker_manager 
)

ug_library(cyber_blocker_intra_writer
  HDRS intra_writer.h
  DEPENDS cyber_blocker_manager
)