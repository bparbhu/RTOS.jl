# 4. Inter-Process Communication (IPC.jl) - Optimized with Bumper.jl
module IPC

using Bumper
export send_message, receive_message, queue_size, clear_queue

# Use Bumper RingBuffer for efficient message handling
const MESSAGE_QUEUE = RingBuffer{Tuple{Any, Int}}(256)  # 256-capacity ring buffer

function send_message(msg::Any, priority::Int=1)
    if !isfull(MESSAGE_QUEUE)
        push!(MESSAGE_QUEUE, (msg, priority))
    else
        @warn "Message queue is full, dropping message"
    end
end

function receive_message()
    return isempty(MESSAGE_QUEUE) ? nothing : popfirst!(MESSAGE_QUEUE)[1]
end

function queue_size()
    return length(MESSAGE_QUEUE)
end

function clear_queue()
    empty!(MESSAGE_QUEUE)
end

end # module IPC

