module Shao17

using RCall

export cpt_normal,
    cpt_poisson,
    cpt_poisson_naive,
    cpt_exp,
    cpt_gamma,
    cpt_np

# https://github.com/JuliaInterop/RCall.jl/issues/287
changepoint = Ref{Module}()
changepoint_np = Ref{Module}()

function __init__()
    changepoint[] = rimport("changepoint")
    changepoint_np[] = rimport("changepoint.np")
end

include("detect.jl")

end
