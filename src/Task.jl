# 3. Task Management (Task.jl) - Optimized with Lifecycle States
module Task

export create_task, run_task, suspend_task, resume_task

mutable struct TaskStruct
    name::String
    action::Function
    priority::Int
    state::Symbol  # :Ready, :Running, :Suspended
end

global TASKS = Dict{String, TaskStruct}()

function create_task(name::String, action::Function, priority::Int=1)
    TASKS[name] = TaskStruct(name, action, priority, :Ready)
end

function run_task(name::String)
    if haskey(TASKS, name) && TASKS[name].state != :Suspended
        TASKS[name].state = :Running
        TASKS[name].action()
        TASKS[name].state = :Ready
    end
end

function suspend_task(name::String)
    if haskey(TASKS, name)
        TASKS[name].state = :Suspended
    end
end

function resume_task(name::String)
    if haskey(TASKS, name)
        TASKS[name].state = :Ready
    end
end

end # module Task
