# RingBuffer.jl - A Circular Buffer Implementation using Bumper.jl

module RingBuffer

using Bumper
export RingBuffer, push!, popfirst!, isfull, isempty, length

mutable struct RingBuffer{T}
    buffer::MallocArray{T}
    head::Int
    tail::Int
    capacity::Int
end

function RingBuffer{T}(capacity::Int) where T
    buf = MallocArray{T}(capacity)
    return RingBuffer{T}(buf, 1, 1, capacity)
end

function push!(rb::RingBuffer{T}, item::T) where T
    if isfull(rb)
        error("RingBuffer is full")
    end
    rb.buffer[rb.head] = item
    rb.head = (rb.head % rb.capacity) + 1
    return item
end

function popfirst!(rb::RingBuffer{T}) where T
    if isempty(rb)
        error("RingBuffer is empty")
    end
    item = rb.buffer[rb.tail]
    rb.tail = (rb.tail % rb.capacity) + 1
    return item
end

isfull(rb::RingBuffer) = (rb.head % rb.capacity) + 1 == rb.tail
isempty(rb::RingBuffer) = rb.head == rb.tail
length(rb::RingBuffer) = (rb.head - rb.tail) % rb.capacity

end # module RingBuffer

