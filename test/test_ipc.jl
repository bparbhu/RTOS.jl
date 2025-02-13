using Test
using IPC

@testset "IPC Tests" begin
    send_message("test_msg", 5)
    @test queue_size() == 1

    msg = receive_message()
    @test msg == "test_msg"

    @test queue_size() == 0  # Queue should be empty after receiving
end
