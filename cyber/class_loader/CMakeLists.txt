ug_library(
    cyber_class_loader
    SRCS
        class_loader.cc
        utility/class_factory.cc
        utility/class_loader_utility.cc
    
    HDRS
        class_loader.h
        class_loader_register_macro.h
        utility/class_factory.h
        utility/class_loader_utility.h
    
    DEPENDS
        cyber_init
        cyber_common_log
        PocoFoundation
)

ug_library(
    cyber_class_loader_manager
    SRCS
    class_loader_manager.cc
    HDRS
    class_loader_manager.h
    DEPENDS
        cyber_class_loader
)