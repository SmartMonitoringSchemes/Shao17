using Test
using Shao17

X = vcat(fill(1.0, 100), fill(100.0, 100))

@testset "R functions" begin
    @test_nowarn cpt_exp(X, "MBIC", 3)

    @test cpt_gamma(X, "MBIC", 3) == [101]
    @test cpt_normal(X, "MBIC", 3) == [101]
    @test cpt_np(X, "MBIC", 3) == [101]
    @test cpt_poisson(X, "MBIC", 3) == [101]
    @test cpt_poisson_naive(X, "MBIC", 3) == [101]

    eval = evaluation_window([0,1,0,1], [0,1,0,0])
    @test eval.tp == 3
    @test eval.fn == 1

    @test f1(eval) == 0.75
    @test f2(eval) == 0.75
end

@testset "Python functions" begin
    @test cpt_mm(X) == [101]
end

@testset "Julia functions" begin
    @test cpt_hmm(X) == [101]
end
