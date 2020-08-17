# Shao17

[![CI](https://github.com/SmartMonitoringSchemes/Shao17/workflows/CI/badge.svg)](https://github.com/SmartMonitoringSchemes/Shao17/actions?query=workflow%3ACI)
[![CompatHelper](https://github.com/SmartMonitoringSchemes/Shao17/workflows/CompatHelper/badge.svg)](https://github.com/SmartMonitoringSchemes/Shao17/actions?query=workflow%3ACompatHelper)
[![codecov](https://codecov.io/gh/SmartMonitoringSchemes/Shao17/branch/master/graph/badge.svg?token=FUxrMFrAdc)](https://codecov.io/gh/SmartMonitoringSchemes/Shao17)

In this repository, we reproduce (partially) the results of the following paper:
-  W. Shao, J. Rougier, A. Paris, F. Devienne and M. Viste, "One-to-One Matching of RTT and Path Changes," _2017 29th International Teletraffic Congress (ITC 29)_, Genoa, 2017, pp. 196-204. https://arxiv.org/pdf/1709.04819.pdf.

We reuse the authors code and dataset ([WenqinSHAO/rtt](https://github.com/WenqinSHAO/rtt.git)) written in R and Python, and add the HDP-HMM in the benchmark. 
We are able to reproduce exactly the same results as in the paper.

## Modifications

- [`external/rtt`](/external/rtt): copy of [`WenqinSHAO/rtt`](https://github.com/WenqinSHAO/rtt.git) modified to work with Python 3.

## Usage

Tested with Julia 1.4+, Python 3.6+, R 4.0+.  
Please see [Overview/Usage](https://github.com/SmartMonitoringSchemes/Overview/blob/master/README.md#usage) first.

```bash
# R dependencies
R -e "install.packages('changepoint', repos = 'http://cran.us.r-project.org')"
R -e "install.packages('changepoint.np', repos = 'http://cran.us.r-project.org')"

# Python dependencies
pip install munkres scikit-learn
```

```bash
# In Shao17/
julia --project=notebooks/ -e 'import Pkg; Pkg.instantiate()'
jupyter lab
```

## Notebooks

Name | Description
:----|:-----------
[Benchmark](/notebooks/Benchmark.ipynb) | Benchmark of the HDP-HMM and several classical changepoint detection methods.
