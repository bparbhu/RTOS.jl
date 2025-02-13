# 13. Synchronization Primitives (Sync.jl) - Mutex, Semaphores, Notifications
module Sync

using Base.Threads

export create_mutex, lock_mutex, unlock_mutex, create_semaphore, take_semaphore, give_semaphore, send_notification, receive_notification

mutable struct Mutex
    owner::Union{Nothing, Task}
    waiting_tasks::Vector{Task}
end

global MUTEXES = Dict{String, Mutex}()

function create_mutex(name::String)
    MUTEXES[name] = Mutex(nothing, [])
end

function lock_mutex(name::String, task::Task)
    if !haskey(MUTEXES, name)
        error("Mutex not found: " * name)
    end
    mutex = MUTEXES[name]
    if mutex.owner === nothing
        mutex.owner = task
    else
        push!(mutex.waiting_tasks, task)
    end
end

function unlock_mutex(name::String)
    if !haskey(MUTEXES, name)
        error("Mutex not found: " * name)
    end
    mutex = MUTEXES[name]
    if length(mutex.waiting_tasks) > 0
        mutex.owner = popfirst!(mutex.waiting_tasks)
    else
        mutex.owner = nothing
    end
end

mutable struct Semaphore
    count::Int
    waiting_tasks::Vector{Task}
end

global SEMAPHORES = Dict{String, Semaphore}()

function create_semaphore(name::String, initial_count::Int)
    SEMAPHORES[name] = Semaphore(initial_count, [])
end

function take_semaphore(name::String, task::Task)
    if !haskey(SEMAPHORES, name)
        error("Semaphore not found: " * name)
    end
    semaphore = SEMAPHORES[name]
    if semaphore.count > 0
        semaphore.count -= 1
    else
        push!(semaphore.waiting_tasks, task)
    end
end

function give_semaphore(name::String)
    if !haskey(SEMAPHORES, name)
        error("Semaphore not found: " * name)
    end
    semaphore = SEMAPHORES[name]
    if length(semaphore.waiting_tasks) > 0
        popfirst!(semaphore.waiting_tasks)
    else
        semaphore.count += 1
    end
end

mutable struct Notification
    state::Int
    value::Int
end

global NOTIFICATIONS = Dict{String, Notification}()

function send_notification(task_name::String, state::Int, value::Int=0)
    NOTIFICATIONS[task_name] = Notification(state, value)
end

function receive_notification(task_name::String)
    if haskey(NOTIFICATIONS, task_name)
        return NOTIFICATIONS[task_name]
    else
        return nothing
    end
end

end # module Sync
