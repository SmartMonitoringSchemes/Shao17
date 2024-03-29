module Shao17

using ConjugatePriors: NormalInverseChisq
using Distributions
using HDPHMM
using PyCall
using RCall

# Re-export enablemissing(...)
using HDPHMM: enablemissing
export enablemissing

export cpt_normal,
    cpt_poisson,
    cpt_poisson_naive,
    cpt_exp,
    cpt_gamma,
    cpt_np,
    cpt_mm,
    cpt_hmm,
    EvaluationResult,
    WeightedEvaluationResult,
    evaluation_window,
    evaluation_window_weighted,
    f1,
    f2,
    f2w

# https://github.com/JuliaPy/PyCall.jl#using-pycall-from-julia-modules
const BayesianGaussianMixture = PyNULL()
const rtt_benchmark = PyNULL()

# https://github.com/JuliaInterop/RCall.jl/issues/287
changepoint = Ref{Module}()
changepoint_np = Ref{Module}()

function __init__()
    # Python modules
    pushfirst!(
        PyVector(pyimport("sys")."path"),
        joinpath(@__DIR__, "..", "external", "rtt"),
    )
    copy!(BayesianGaussianMixture, pyimport_conda("sklearn.mixture", "scikit-learn").BayesianGaussianMixture)
    copy!(rtt_benchmark, pyimport("localutils.benchmark"))

    # R modules
    changepoint[] = rimport("changepoint")
    changepoint_np[] = rimport("changepoint.np")
end

include("benchmark.jl")
include("detect.jl")
include("detect_mm.jl")
include("detect_hmm.jl")

end
