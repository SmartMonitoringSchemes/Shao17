# Julia wrapper of changepoint detection methods implemented in rtt/localutils/changedetect.py
# NOTE: Missing (negative) values are not handled here, instead we coalesce the timeseries beforehand

function r_cpts(obj::RObject)
    changepoints = rcopy(changepoint[].cpts(obj))
    if typeof(changepoints) == Int
        changepoints = [changepoints]
    end
    # The `changepoint.np` package documentation indicates that
    # > A changepoint is denoted as the first observation of the new segment
    # but it seems that the indices are shifted by 1 (even though R is 1-indexed):
    #     library(changepoint.np)
    #     data <- c(0,0,0,0,0,0,100,100,100,100)
    #     cpt.np(data, penalty="MBIC")
    #     # Changepoint Locations : 6
    #     # c(0,0,0,0,0,0,100,100,100,100)
    #     #   1 2 3 4 5 6 7   8   9   10
    #     #             ^ 7 is expected
    changepoints .+ 1
end

function cpt_normal(x::Vector{Float64}, penalty::AbstractString, minseglen::Int)
    @assert minimum(x) > 0
    r_cpts(changepoint[].cpt_meanvar(
        x,
        var"test.stat" = "Normal",
        method = "PELT",
        penalty = penalty,
        minseglen = minseglen,
    ))
end

function cpt_poisson(x::Vector{Float64}, penalty::AbstractString, minseglen::Int)
    @assert minimum(x) > 0
    x = round.(Int, x)
    x = x .- minimum(x)
    r_cpts(changepoint[].cpt_meanvar(
        x,
        var"test.stat" = "Poisson",
        method = "PELT",
        penalty = penalty,
        minseglen = minseglen,
    ))
end

function cpt_poisson_naive(x::Vector{Float64}, penalty::AbstractString, minseglen::Int)
    @assert minimum(x) > 0
    x = round.(Int, x)
    r_cpts(changepoint[].cpt_meanvar(
        x,
        var"test.stat" = "Poisson",
        method = "PELT",
        penalty = penalty,
        minseglen = minseglen,
    ))
end

function cpt_exp(x::Vector{Float64}, penalty::AbstractString, minseglen::Int)
    @assert minimum(x) > 0
    x = x .- minimum(x)
    r_cpts(changepoint[].cpt_meanvar(
        x,
        var"test.stat" = "Exponential",
        method = "PELT",
        penalty = penalty,
        minseglen = minseglen,
    ))
end

# NOTE: We don't specify shape here (default value ?)
# Cannot reproduce author results with shape = 100
# Default value = 1 (probably what was used in the original paper)
function cpt_gamma(x::Vector{Float64}, penalty::AbstractString, minseglen::Int)
    @assert minimum(x) > 0
    x = x .- minimum(x) .+ 0.1
    r_cpts(changepoint[].cpt_meanvar(
        x,
        var"test.stat" = "Gamma",
        method = "PELT",
        penalty = penalty,
        minseglen = minseglen,
    ))
end

function cpt_np(x::Vector{Float64}, penalty::AbstractString, minseglen::Int)
    @assert minimum(x) > 0
    r_cpts(changepoint_np[].cpt_np(x, penalty = penalty, minseglen = minseglen))
end
