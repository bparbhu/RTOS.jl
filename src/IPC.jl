# 4. Inter-Process Communication (IPC.jl) - Optimized for High-Speed Messaging
module IPC

export send_message, receive_message, queue_size, clear_queue

mutable struct MessageQueue
    queue::Vector{Tuple{Any, Int}}  # Message, Priority
end

global MESSAGE_QUEUE = MessageQueue([])

function send_message(msg::Any, priority::Int=1)
    push!(MESSAGE_QUEUE.queue, (msg, priority))
    sort!(MESSAGE_QUEUE.queue, by = x -> -x[2])
end

function receive_message()
    return isempty(MESSAGE_QUEUE.queue) ? nothing : popfirst!(MESSAGE_QUEUE.queue)[1]
end

function queue_size()
    return length(MESSAGE_QUEUE.queue)
end

function clear_queue()
    empty!(MESSAGE_QUEUE.queue)
end

end # module IPC
