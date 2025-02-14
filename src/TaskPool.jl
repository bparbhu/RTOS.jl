module TaskPool

using Bumper
export schedule_task, next_task, pending_tasks

const TASK_QUEUE = RingBuffer{Function}(128)

schedule_task(task::Function) = isfull(TASK_QUEUE) ? @warn("Task queue full") : push!(TASK_QUEUE, task)
next_task() = isempty(TASK_QUEUE) ? nothing : popfirst!(TASK_QUEUE)
pending_tasks() = length(TASK_QUEUE)

end # module TaskPool