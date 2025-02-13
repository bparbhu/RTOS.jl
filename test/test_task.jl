using Test
using Task

@testset "Task Management Tests" begin
    create_task("example_task", () -> println("Running task"), 2)
    @test TASKS["example_task"].priority == 2

    suspend_task("example_task")
    @test TASKS["example_task"].state == :Suspended

    resume_task("example_task")
    @test TASKS["example_task"].state == :Ready
end
