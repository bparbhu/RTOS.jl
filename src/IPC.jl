# 4. Inter-Process Communication (IPC.jl) - Optimized with Bumper.jl and RingBuffer.jl
module IPC

using RingBuffer  # Use the custom RingBuffer module
export send_message, receive_message, queue_size, clear_queue

# Initialize the ring buffer for message handling
const MESSAGE_QUEUE = RingBuffer.RingBuffer{Tuple{Any, Int}}(256)

function send_message(msg::Any, priority::Int=1)
    if !RingBuffer.isfull(MESSAGE_QUEUE)
        RingBuffer.push!(MESSAGE_QUEUE, (msg, priority))
    else
        @warn "Message queue is full, dropping message"
    end
end

function receive_message()
    return RingBuffer.isempty(MESSAGE_QUEUE) ? nothing : RingBuffer.popfirst!(MESSAGE_QUEUE)[1]
end

function queue_size()
    return RingBuffer.length(MESSAGE_QUEUE)
end

function clear_queue()
    while !RingBuffer.isempty(MESSAGE_QUEUE)
        RingBuffer.popfirst!(MESSAGE_QUEUE)
    end
end

end # module IPC

