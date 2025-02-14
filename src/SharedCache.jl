module SharedCache

using Bumper
export get_value, set_value, clear_cache

const CACHE = Bumper.Dictionary{String, Any}(256)

set_value(key::String, value::Any) = CACHE[key] = value
get_value(key::String) = get(CACHE, key, nothing)
clear_cache() = empty!(CACHE)

end # module SharedCache