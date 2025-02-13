using Test
using Timers

@testset "Timer Tests" begin
    test_triggered = false
    function timer_callback()
        global test_triggered
        test_triggered = true
    end

    start_timer(0.3, timer_callback)
    sleep(0.4)
    
    @test test_triggered == true
end
