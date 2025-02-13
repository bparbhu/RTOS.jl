# 11. Utility Functions (Utils.jl) - Optimized for Performance Metrics
module Utils

using Dates

export get_system_time, format_time, uptime, cpu_usage

const START_TIME = time()
const CPU_LOAD_HISTORY = Float64[]

function get_system_time()
    return time()
end

function format_time(t::Float64)
    return string(Dates.unix2datetime(t))
end

function uptime()
    return time() - START_TIME
end

function cpu_usage()
    push!(CPU_LOAD_HISTORY, rand(0.1:0.1:1.0)) # Simulated CPU load
    return mean(CPU_LOAD_HISTORY)
end

end # module Utils