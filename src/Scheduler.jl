# 2. Scheduler (Scheduler.jl) - Optimized Preemptive Scheduling
module Scheduler

using Base.Threads

export start_scheduler, add_task, remove_task, list_tasks, set_task_priority, yield_task, stop_task, resume_task

mutable struct TaskQueue
    tasks::Vector{Tuple{Function, Int, Bool}}  # Function, Priority, Active status
end

global TASK_QUEUE = TaskQueue([])

global STOPPED_TASKS = Set{Function}()

function start_scheduler()
    while true
        sorted_tasks = sort(TASK_QUEUE.tasks, by = x -> -x[2])  # Higher priority first
        for (task, _, active) in sorted_tasks
            if active && task ∉ STOPPED_TASKS
                try
                    task()
                catch e
                    println("[ERROR] Task failure: ", e)
                end
            end
        end
        yield()
    end
end

function add_task(task::Function, priority::Int=1)
    push!(TASK_QUEUE.tasks, (task, priority, true))
end

function remove_task(task::Function)
    filter!(x -> x[1] != task, TASK_QUEUE.tasks)
end

function list_tasks()
    return [(task, priority, active) for (task, priority, active) in TASK_QUEUE.tasks]
end

function set_task_priority(task::Function, priority::Int)
    for i in eachindex(TASK_QUEUE.tasks)
        if TASK_QUEUE.tasks[i][1] == task
            TASK_QUEUE.tasks[i] = (task, priority, TASK_QUEUE.tasks[i][3])
        end
    end
end

function yield_task()
    sleep(0.005)
end

function stop_task(task::Function)
    for i in eachindex(TASK_QUEUE.tasks)
        if TASK_QUEUE.tasks[i][1] == task
            TASK_QUEUE.tasks[i] = (task, TASK_QUEUE.tasks[i][2], false)
        end
    end
end

function resume_task(task::Function)
    for i in eachindex(TASK_QUEUE.tasks)
        if TASK_QUEUE.tasks[i][1] == task
            TASK_QUEUE.tasks[i] = (task, TASK_QUEUE.tasks[i][2], true)
        end
    end
end

end # module Scheduler