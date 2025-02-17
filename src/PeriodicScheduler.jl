module PeriodicScheduler

using PeriodicSystems
using TimerOutputs
include("RingBuffer.jl")  # Import the local RingBuffer module

export add_periodic_task, remove_periodic_task, start_periodic_scheduler, stop_periodic_scheduler

mutable struct PeriodicTask
    task::Function
    period::Float64
    next_run::Float64
end

const TASKS = RingBuffer{PeriodicTask}(256)

function add_periodic_task(task::Function, period::Float64)
    push!(TASKS, PeriodicTask(task, period, time()))
end

function remove_periodic_task(task::Function)
    for i in 1:length(TASKS)
        if TASKS[i].task == task
            deleteat!(TASKS, i)
            break
        end
    end
end

function start_periodic_scheduler()
    while true
        for t in TASKS
            if time() >= t.next_run
                @timeit "Periodic Task" t.task()
                t.next_run = time() + t.period
            end
        end
        sleep(0.001)
    end
end

function stop_periodic_scheduler()
    empty!(TASKS)
end

end # module PeriodicScheduler

