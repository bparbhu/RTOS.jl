# RTOS.jl - High-Performance Real-Time Operating System

# 1. Main Entry Point (RTOS.jl)
module RTOS

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

export start_scheduler, create_task, send_message, receive_message, allocate_memory, start_timer, compile_rtos, handle_interrupt, init_driver, log_event, get_system_time, set_task_priority, yield_task, stop_task, register_watchdog, reset_watchdog, detect_deadlock

end # module RTOS