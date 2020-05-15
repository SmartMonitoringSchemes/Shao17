# Julia wrapper for rtt/localutils/benchmark.py

struct EvaluationResult
    tp::Int
    fp::Int
    fn::Int
    precision::Float64
    recall::Float64
    dis::Float64
end

struct WeightedEvaluationResult
    tp::Int
    fp::Int
    fn::Int
    precision::Float64
    recall::Float64
    dis::Float64
    score::Float64
end

function EvaluationResult(benchmark::Dict)
    EvaluationResult(benchmark["tp"], benchmark["fp"], benchmark["fn"], benchmark["precision"], benchmark["recall"], benchmark["dis"])
end

function WeightedEvaluationResult(benchmark::Dict)
    WeightedEvaluationResult(benchmark["tp"], benchmark["fp"], benchmark["fn"], benchmark["precision"], benchmark["recall"], benchmark["dis"], benchmark["score"])
end

function evaluation_window(fact::Vector{Int}, detection::Vector{Int}; window=0)
    EvaluationResult(rtt_benchmark.evaluation_window(PyVector(fact), PyVector(detection), window))
end

function evaluation_window_weighted(trace::Vector{Float64}, fact::Vector{Int}, detection::Vector{Int}; window=0)
    WeightedEvaluationResult(rtt_benchmark.evaluation_window_weighted(trace, PyVector(fact), PyVector(detection), window))
end

f1(e::Union{EvaluationResult, WeightedEvaluationResult}) = 2*(e.precision*e.recall)/(e.precision+e.recall)
f2(e::Union{EvaluationResult, WeightedEvaluationResult}) = 5*(e.precision*e.recall)/(4*e.precision+e.recall)
f2w(e::WeightedEvaluationResult) = 5*(e.precision*e.score)/(4*e.precision+e.score)
