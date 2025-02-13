using Test
using Safety

@testset "Safety Tests" begin
    test_triggered = false
    function test_callback()
        global test_triggered
        test_triggered = true
    end

    register_watchdog("test_watchdog", 0.5, test_callback)
    sleep(0.6)

    @test test_triggered == true

    enable_deadlock_prevention(true)
    TASK_LOCKS["test_task"] = true
    detect_deadlock("test_task")

    @test TASK_LOCKS["test_task"] == false  # Should auto-resolve deadlock
end
