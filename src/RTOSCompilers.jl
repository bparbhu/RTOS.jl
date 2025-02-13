# 7. Static Compilation Integration (RTOSCompiler.jl)
module RTOSCompiler

using StaticCompiler

export compile_rtos

function compile_rtos(func::Function)
    return compile(func)
end

end # module RTOSCompiler