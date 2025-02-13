using Test
using Scheduler

@testset "Scheduler Tests" begin
    function test_task()
        println("Task executed")
    end

    add_task(test_task, 3)
    @test length(list_tasks()) == 1

    stop_task(test_task)
    @test list_tasks()[1][3] == false  # Should be inactive
end
