#ResourceMonitor.jl - Tracks System Resource Usage

module ResourceMonitor

using Bumper
export monitor_resources, resource_summary

const RESOURCE_LOG = Bumper.Vector{Dict{String, Any}}(128)

monitor_resources(info::Dict{String, Any}) = push!(RESOURCE_LOG, info)
resource_summary() = mapreduce(identity, vcat, RESOURCE_LOG)

end # module ResourceMonitor