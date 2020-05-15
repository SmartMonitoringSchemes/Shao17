function prior(data)
    obs_med, obs_var = robuststats(Normal, data)
    tp = TransitionDistributionPrior(Gamma(1, 1 / 0.01), Gamma(1, 1 / 0.01), Beta(500, 1))
    op = DPMMObservationModelPrior{Normal}(
        # NormalInverseChisq(obs_med, obs_var, 1, 10),
        NormalInverseChisq(obs_med, 20, 1, 5),
        Gamma(1, 0.5),
    )
    BlockedSamplerPrior(1.0, tp, op)
end

function segment(data; L = 10, LP = 5)
    config = MCConfig(init = KMeansInit(L), iter = 200, verb = false)
    chains = HDPHMM.sample(BlockedSampler(L, LP), prior(data), data, config = config)
    select_hamming(chains[1])[2]
end

function cpt_hmm(x)
    z = segment(x)
    findall(z[2:end] .!= z[1:end-1]) .+ 1
end
