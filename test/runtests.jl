using Test

include("test_scheduler.jl")
include("test_task.jl")
include("test_ipc.jl")
include("test_memory.jl")
include("test_timers.jl")
include("test_rtoscompiler.jl")
include("test_interrupts.jl")
include("test_drivers.jl")
include("test_debug.jl")
include("test_utils.jl")
include("test_safety.jl")
include("test_sync.jl")

println("✅ All tests completed successfully!")
