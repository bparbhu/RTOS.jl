# 12. Safety Mechanisms (Safety.jl) - Advanced Watchdog & Deadlock Prevention
module Safety

using Base.Threads

export register_watchdog, reset_watchdog, detect_deadlock, enable_deadlock_prevention, enable_watchdog_monitoring

mutable struct Watchdog
    timeout::Float64
    last_reset::Float64
    callback::Function
    active::Bool
end

global WATCHDOGS = Dict{String, Watchdog}()

global TASK_LOCKS = Dict{String, Bool}()

global DEADLOCK_PREVENTION_ENABLED = false

global WATCHDOG_MONITORING_ENABLED = false

function register_watchdog(name::String, timeout::Float64, callback::Function)
    WATCHDOGS[name] = Watchdog(timeout, time(), callback, true)
    if WATCHDOG_MONITORING_ENABLED
        @async monitor_watchdogs()
    end
end

function reset_watchdog(name::String)
    if haskey(WATCHDOGS, name)
        WATCHDOGS[name].last_reset = time()
    end
end

function detect_deadlock(task_name::String)
    if haskey(TASK_LOCKS, task_name) && TASK_LOCKS[task_name]
        println("[WARNING] Deadlock detected for task: ", task_name)
        if DEADLOCK_PREVENTION_ENABLED
            TASK_LOCKS[task_name] = false  # Force unlock
            println("[SAFETY] Deadlock automatically resolved for task: ", task_name)
        end
    end
end

function enable_deadlock_prevention(state::Bool)
    global DEADLOCK_PREVENTION_ENABLED = state
end

function enable_watchdog_monitoring(state::Bool)
    global WATCHDOG_MONITORING_ENABLED = state
    if state
        @async monitor_watchdogs()
    end
end

function monitor_watchdogs()
    while WATCHDOG_MONITORING_ENABLED
        sleep(0.1)
        for (name, watchdog) in WATCHDOGS
            if watchdog.active && time() - watchdog.last_reset > watchdog.timeout
                println("[SAFETY] Watchdog timeout triggered for: ", name)
                watchdog.callback()
                watchdog.active = false
            end
        end
    end
end

end # module Safety