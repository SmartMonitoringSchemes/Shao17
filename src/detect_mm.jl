function segment_dpmm(data)
    obs_med, obs_var = robuststats(Normal, data)
    mm = BayesianGaussianMixture(
        20, n_init = 1, mean_prior = [obs_med]
    )
    mm.fit_predict(reshape(data, :, 1)) .+ 1
end

function cpt_mm(x)
    z = segment_dpmm(x)
    findall(z[2:end] .!= z[1:end-1]) .+ 1
end