# 9. Device Drivers (Drivers.jl) - Optimized with Thread Safety
module Drivers

using Base.Threads

export init_driver, shutdown_driver, list_drivers, driver_status

mutable struct Driver
    name::String
    initialized::Bool
end

global DRIVERS = Dict()
lock = ReentrantLock()

function init_driver(name::String)
    lock(lock) do
        DRIVERS[name] = Driver(name, true)
        println("[INFO] Driver initialized: ", name)
    end
end

function shutdown_driver(name::String)
    lock(lock) do
        if haskey(DRIVERS, name)
            delete!(DRIVERS, name)
            println("[INFO] Driver shut down: ", name)
        else
            println("[WARNING] Driver not found: ", name)
        end
    end
end

function list_drivers()
    return collect(keys(DRIVERS))
end

function driver_status(name::String)
    return haskey(DRIVERS, name) ? "Active" : "Inactive"
end

end # module Drivers