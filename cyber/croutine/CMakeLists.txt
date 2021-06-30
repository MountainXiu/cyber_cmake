ug_library(
    cyber_croutine
    SRCS croutine.cc
    HDRS croutine.h

    DEPENDS 
        cyber_base_atomic_hash_map
        cyber_base_atomic_rw_lock
        cyber_base_bounded_queue
        cyber_base_concurrent_object_pool
        cyber_base_macros
        cyber_base_wait_strategy
        cyber_common
        cyber_croutine_routine_context
        cyber_croutine_routine_factory
        cyber_croutine_swap
        cyber_event_perf_event_cache
        cyber_time
        rt
        atomic
)

ug_library(
  cyber_croutine_routine_context
    SRCS detail/routine_context.cc
    HDRS detail/routine_context.h
    DEPENDS 
        cyber_common
    
)

ug_library(
  cyber_croutine_routine_factory
    HDRS routine_factory.h
    DEPENDS 
        cyber_common
        cyber_event_perf_event_cache
    
)

ENABLE_LANGUAGE(ASM)
set(croutine_swap_src "")
if (${CMAKE_HOST_SYSTEM_PROCESSOR} MATCHES "x86_64")
  set(croutine_swap_src detail/swap_x86_64.S)
else()
  set(croutine_swap_src detail/swap_aarch64.S)
endif()

ug_library(
  cyber_croutine_swap
    SRCS ${croutine_swap_src}
  DEPENDS 
    rt
)
