#EventLogger.jl - Logs System Events

module EventLogger

using Bumper
export log_event_data, event_history

const EVENT_LOG = Bumper.RingBuffer{Tuple{String, Dates.DateTime}}(256)

log_event_data(event::String) = push!(EVENT_LOG, (event, Dates.now()))
event_history() = collect(EVENT_LOG)

end # module EventLogger