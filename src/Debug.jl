# 10. Debugging Tools (Debug.jl) - Enhanced with Log Levels
module Debug

export log_event, set_debug_mode, set_log_level

const LOG_LEVELS = Dict("INFO" => 1, "WARNING" => 2, "ERROR" => 3)

global DEBUG_MODE = true

global CURRENT_LOG_LEVEL = LOG_LEVELS["INFO"]

function log_event(level::String, event::String)
    if DEBUG_MODE && LOG_LEVELS[level] >= CURRENT_LOG_LEVEL
        println("[", level, "] ", event)
    end
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

end # module Debug