# 10. Debugging Tools (Debug.jl) - Structured Logging & Event Tracing
module Debug

export log_event, set_debug_mode, set_log_level, trace_event, dump_event_log, clear_event_log

const LOG_LEVELS = Dict("INFO" => 1, "WARNING" => 2, "ERROR" => 3, "TRACE" => 0, "CRITICAL" => 4)

global DEBUG_MODE = true

global CURRENT_LOG_LEVEL = LOG_LEVELS["INFO"]

global EVENT_LOG = []

function log_event(level::String, event::String)
    if DEBUG_MODE && LOG_LEVELS[level] >= CURRENT_LOG_LEVEL
        timestamp = time()
        println("[", level, " - ", timestamp, "] ", event)
        push!(EVENT_LOG, (timestamp, level, event))
    end
end

function trace_event(event::String)
    log_event("TRACE", event)
end

function set_debug_mode(state::Bool)
    global DEBUG_MODE = state
end

function set_log_level(level::String)
    if haskey(LOG_LEVELS, level)
        global CURRENT_LOG_LEVEL = LOG_LEVELS[level]
    else
        println("[ERROR] Invalid log level: ", level)
    end
end

function dump_event_log()
    return copy(EVENT_LOG)
end

function clear_event_log()
    empty!(EVENT_LOG)
end

end # module Debug
