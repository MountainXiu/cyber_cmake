ug_library(cyber_base_atomic_hash_map
  HDRS
    atomic_hash_map.h
)

ug_library(cyber_base_atomic_rw_lock
  HDRS
    atomic_rw_lock.h
  DEPENDS
    cyber_base_rw_lock_guard
)

ug_library(cyber_base_bounded_queue
  HRDS 
    bounded_queue.h
  DEPENDS 
    cyber_base_macros
    cyber_base_wait_strategy
)

ug_library(cyber_base_concurrent_object_pool
  HDRS
    concurrent_object_pool.h
  DEPENDS
    cyber_base_for_each
)

ug_library(cyber_base_for_each
  HDRS
    for_each.h
  DEPENDS
    cyber_base_macros
)

ug_library(cyber_base_macros
  HDRS macros.h
)

ug_library(cyber_base_object_pool
  HDRS
    object_pool.h
  DEPENDS
    cyber_base_for_each
    cyber_base_macros
)

ug_library(
    cyber_base_reentrant_rw_lock
    HDRS 
    reentrant_rw_lock.h
)

ug_library(
    cyber_base_rw_lock_guard
    HDRS 
    rw_lock_guard.h
)

ug_library(
    cyber_base_signal
    HDRS 
    signal.h
)


ug_library(
    cyber_base_thread_pool
    HDRS 
    thread_pool.h
)

ug_library(
    cyber_base_thread_safe_queue
    HDRS 
    thread_safe_queue.h
)

ug_library(
    cyber_base_unbounded_queue
    HDRS 
    unbounded_queue.h
)


ug_library(
    cyber_base_wait_strategy
    HDRS 
    wait_strategy.h
)

ug_library(cyber_base
  cyber_base
  DEPENDS
  cyber_base_atomic_hash_map
  cyber_base_atomic_rw_lock
  cyber_base_bounded_queue
  cyber_base_concurrent_object_pool
  cyber_base_for_each
  cyber_base_macros
  cyber_base_object_pool
  cyber_base_reentrant_rw_lock
  cyber_base_rw_lock_guard
  cyber_base_signal
  cyber_base_thread_pool
  cyber_base_thread_safe_queue
  cyber_base_unbounded_queue
  cyber_base_wait_strategy
)