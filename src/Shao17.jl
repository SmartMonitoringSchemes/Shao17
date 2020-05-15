module Shao17

using PyCall
using RCall

export cpt_normal,
    cpt_poisson,
    cpt_poisson_naive,
    cpt_exp,
    cpt_gamma,
    cpt_np,
    EvaluationResult,
    WeightedEvaluationResult,
    evaluation_window,
    evaluation_window_weighted,
    f1,
    f2,
    f2w

# https://github.com/JuliaPy/PyCall.jl#using-pycall-from-julia-modules
const rtt_benchmark = PyNULL()

# https://github.com/JuliaInterop/RCall.jl/issues/287
changepoint = Ref{Module}()
changepoint_np = Ref{Module}()

function __init__()
    # Python modules
    pushfirst!(PyVector(pyimport("sys")."path"), joinpath(@__DIR__, "..", "external", "rtt"))
    copy!(rtt_benchmark, pyimport("localutils.benchmark"))

    # R modules
    changepoint[] = rimport("changepoint")
    changepoint_np[] = rimport("changepoint.np")
end

include("benchmark.jl")
include("detect.jl")

end
