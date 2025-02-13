using Test
using Sync

@testset "Synchronization Tests" begin

    @testset "Mutex Tests" begin
        create_mutex("test_mutex")

        lock_mutex("test_mutex", "task_1")
        @test is_mutex_locked("test_mutex") == true

        @test try_lock_mutex("test_mutex", "task_2") == false

        unlock_mutex("test_mutex")
        @test is_mutex_locked("test_mutex") == false

        @test timed_lock_mutex("test_mutex", "task_3", 1.0) == true
        unlock_mutex("test_mutex")
    end

    @testset "Semaphore Tests" begin
        create_semaphore("test_semaphore", 2)

        take_semaphore("test_semaphore", "task_1")
        @test is_semaphore_available("test_semaphore") == true

        @test try_take_semaphore("test_semaphore") == true
        @test try_take_semaphore("test_semaphore") == false  # Should be empty now

        give_semaphore("test_semaphore")
        @test is_semaphore_available("test_semaphore") == true

        @test timed_take_semaphore("test_semaphore", 1.0) == true
    end

    @testset "Notification Tests" begin
        send_notification("task_1", 1, 42)
        notif = receive_notification("task_1")

        @test notif.state == 1
        @test notif.value == 42
    end

end
