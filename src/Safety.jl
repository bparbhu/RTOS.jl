# 12. Safety Mechanisms (Safety.jl) - Watchdog Timers & Deadlock Detection
module Safety

using Base.Threads

export register_watchdog, reset_watchdog, detect_deadlock

mutable struct Watchdog
    timeout::Float64
    last_reset::Float64
    callback::Function
end

global WATCHDOGS = Dict{String, Watchdog}()

global TASK_LOCKS = Dict{String, Bool}()

function register_watchdog(name::String, timeout::Float64, callback::Function)
    WATCHDOGS[name] = Watchdog(timeout, time(), callback)
    @async begin
        while true
            sleep(0.1)
            if haskey(WATCHDOGS, name) && time() - WATCHDOGS[name].last_reset > WATCHDOGS[name].timeout
                println("[SAFETY] Watchdog timeout triggered for: ", name)
                WATCHDOGS[name].callback()
                delete!(WATCHDOGS, name)
            end
        end
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
    end
end

end # module Safety
