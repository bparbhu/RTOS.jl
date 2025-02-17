# RTOS.jl - High-Performance Real-Time Operating System

module RTOS

using Dates
using Bumper
using StaticCompiler
using ThreadsX
using LoggingExtras
using TimerOutputs
using Preferences
using StrideArrays
using PeriodicSystems
using DifferentialEquations  # SciML integration
using ModelingToolkit       # SciML integration

include("Scheduler.jl")
include("Task.jl")
include("IPC.jl")
include("Memory.jl")
include("Timers.jl")
include("RTOSCompiler.jl")
include("Interrupts.jl")
include("Drivers.jl")
include("Debug.jl")
include("Utils.jl")
include("Safety.jl")
include("Sync.jl")
include("SharedCache.jl")
include("TaskPool.jl")
include("ResourceMonitor.jl")
include("PowerManager.jl")
include("EventLogger.jl")
include("FaultTolerance.jl")
include("LoadBalancer.jl")
include("Analytics.jl")
include("ConfigManager.jl")

# Future integrations with SciML ecosystem
include("SystemModeling.jl")   # For dynamic system modeling
include("Optimization.jl")     # For resource optimization
include("ControlSystems.jl")   # For control system integration

export start_scheduler,
create_task,
send_message,
receive_message,
allocate_memory,
start_timer,
compile_rtos,
handle_interrupt,
init_driver,
log_event,
get_system_time,
set_task_priority,
yield_task,
stop_task,
register_watchdog,
reset_watchdog,
detect_deadlock,
enable_deadlock_prevention,
enable_watchdog_monitoring,
send_notification,
receive_notification,
create_mutex,
lock_mutex,
unlock_mutex,
create_semaphore,
take_semaphore,
give_semaphore,
try_lock_mutex,
try_take_semaphore,
is_mutex_locked,
is_semaphore_available,
timed_lock_mutex,
timed_take_semaphore,
monitor_resources,
optimize_power,
log_event_data,
get_value,
set_value,
clear_cache,
schedule_task,
next_task,
pending_tasks,
recover_from_fault,
balance_load,
collect_metrics,
apply_config,
model_system,
optimize_resources,
control_system

end # module RTOS

