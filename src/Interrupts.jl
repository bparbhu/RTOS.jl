# 8. Interrupt Handling (Interrupts.jl) - Optimized for Low-Latency Execution
module Interrupts

export handle_interrupt, register_interrupt

mutable struct InterruptHandler
    handlers::Dict{String, Function}
    priorities::Dict{String, Int} # Priority-based execution
end

global INTERRUPT_REGISTRY = InterruptHandler(Dict(), Dict())

function register_interrupt(interrupt::String, handler::Function, priority::Int=1)
    INTERRUPT_REGISTRY.handlers[interrupt] = handler
    INTERRUPT_REGISTRY.priorities[interrupt] = priority
end

function handle_interrupt(interrupt::String)
    if haskey(INTERRUPT_REGISTRY.handlers, interrupt)
        try
            INTERRUPT_REGISTRY.handlers[interrupt]()
        catch e
            println("[ERROR] Interrupt failure: ", e)
        end
    else
        println("[WARNING] Unhandled interrupt: ", interrupt)
    end
end

end # module Interrupts