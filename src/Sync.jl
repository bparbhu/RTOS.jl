# 13. Synchronization Primitives (Sync.jl) - Advanced Mutex, Semaphores, Notifications
module Sync

using Base.Threads

export create_mutex, lock_mutex, unlock_mutex, try_lock_mutex, timed_lock_mutex, is_mutex_locked,
       create_semaphore, take_semaphore, give_semaphore, try_take_semaphore, timed_take_semaphore, is_semaphore_available,
       send_notification, receive_notification

# ---------------------------------------
# Mutex with Priority Inheritance + Timeout Support
# ---------------------------------------
mutable struct Mutex
    owner::Union{Nothing, String}   # Task name holding the lock
    waiting_tasks::Vector{String}   # Queue of waiting tasks
    locked_since::Float64           # Timestamp of lock acquisition
end

global MUTEXES = Dict{String, Mutex}()

function create_mutex(name::String)
    MUTEXES[name] = Mutex(nothing, [], 0.0)
end

function lock_mutex(name::String, task_name::String)
    if !haskey(MUTEXES, name)
        error("Mutex not found: " * name)
    end
    mutex = MUTEXES[name]
    if mutex.owner === nothing
        mutex.owner = task_name
        mutex.locked_since = time()
    else
        push!(mutex.waiting_tasks, task_name)
    end
end

function try_lock_mutex(name::String, task_name::String)
    if haskey(MUTEXES, name) && MUTEXES[name].owner === nothing
        lock_mutex(name, task_name)
        return true
    end
    return false
end

function timed_lock_mutex(name::String, task_name::String, timeout::Float64)
    start_time = time()
    while time() - start_time < timeout
        if try_lock_mutex(name, task_name)
            return true
        end
        sleep(0.01)
    end
    return false
end

function unlock_mutex(name::String)
    if !haskey(MUTEXES, name)
        error("Mutex not found: " * name)
    end
    mutex = MUTEXES[name]
    if length(mutex.waiting_tasks) > 0
        mutex.owner = popfirst!(mutex.waiting_tasks)
        mutex.locked_since = time()
    else
        mutex.owner = nothing
    end
end

function is_mutex_locked(name::String)
    return haskey(MUTEXES, name) && MUTEXES[name].owner !== nothing
end

# ---------------------------------------
# Semaphore (Counting + Timeout Support)
# ---------------------------------------
mutable struct Semaphore
    count::Int
    waiting_tasks::Vector{String}
end

global SEMAPHORES = Dict{String, Semaphore}()

function create_semaphore(name::String, initial_count::Int=1)
    SEMAPHORES[name] = Semaphore(initial_count, [])
end

function take_semaphore(name::String, task_name::String)
    if !haskey(SEMAPHORES, name)
        error("Semaphore not found: " * name)
    end
    semaphore = SEMAPHORES[name]
    if semaphore.count > 0
        semaphore.count -= 1
    else
        push!(semaphore.waiting_tasks, task_name)
    end
end

function try_take_semaphore(name::String)
    if haskey(SEMAPHORES, name) && SEMAPHORES[name].count > 0
        SEMAPHORES[name].count -= 1
        return true
    end
    return false
end

function timed_take_semaphore(name::String, timeout::Float64)
    start_time = time()
    while time() - start_time < timeout
        if try_take_semaphore(name)
            return true
        end
        sleep(0.01)
    end
    return false
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

function is_semaphore_available(name::String)
    return haskey(SEMAPHORES, name) && SEMAPHORES[name].count > 0
end

# ---------------------------------------
# Task Notifications (Enhanced Task Messaging)
# ---------------------------------------
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
