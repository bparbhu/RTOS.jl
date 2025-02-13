# 5. Memory Management (Memory.jl) - Optimized with Dynamic Pools
module Memory

export allocate_memory, free_memory, memory_status

mutable struct MemoryBlock
    data::Vector{UInt8}
    allocated::Bool
end

global MEMORY_POOL = [MemoryBlock(Vector{UInt8}(undef, 1024), false) for _ in 1:20]

function allocate_memory(size::Int)
    for block in MEMORY_POOL
        if !block.allocated && length(block.data) >= size
            block.allocated = true
            return block.data
        end
    end
    return nothing
end

function free_memory(mem::Vector{UInt8})
    for block in MEMORY_POOL
        if block.data === mem
            block.allocated = false
            return
        end
    end
end

function memory_status()
    return count(b -> !b.allocated, MEMORY_POOL)
end

end # module Memory