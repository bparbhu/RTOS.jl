# 6. Timers (Timers.jl) - Optimized for High-Precision Timing
module Timers

export start_timer, cancel_timer, list_active_timers

mutable struct Timer
    duration::Float64
    callback::Function
    active::Bool
end

global TIMERS = Timer[]

function start_timer(duration::Float64, callback::Function)
    timer = Timer(duration, callback, true)
    push!(TIMERS, timer)
    @async begin
        sleep(duration)
        if timer.active
            callback()
        end
        filter!(t -> t !== timer, TIMERS)
    end
end

function cancel_timer(callback::Function)
    for timer in TIMERS
        if timer.callback == callback
            timer.active = false
        end
    end
end

function list_active_timers()
    return filter(t -> t.active, TIMERS)
end

end # module Timers

