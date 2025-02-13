using Test
using Memory

@testset "Memory Tests" begin
    mem_block = allocate_memory(256)
    @test mem_block !== nothing

    free_memory(mem_block)
    @test memory_status() > 0  # Should have free blocks
end
