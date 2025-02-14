#PowerManager.jl - Manages System Power States

module PowerManager

using Bumper
export optimize_power, power_state

const POWER_MODES = Bumper.Dictionary{String, Bool}(4)

optimize_power(mode::String, state::Bool) = POWER_MODES[mode] = state
power_state(mode::String) = get(POWER_MODES, mode, false)

end # module PowerManager