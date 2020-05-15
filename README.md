# Shao17
(Partial) reproduction of "One-to-One Matching of RTT and Path Changes".

`external/rtt`: local copy of `https://github.com/WenqinSHAO/rtt.git`, modified to work with Python 3.

```bash
# TODO: Julia function to install those packages.
R -e "install.packages('changepoint', repos = 'http://cran.us.r-project.org')"
R -e "install.packages('changepoint.np', repos = 'http://cran.us.r-project.org')"

pip install -r external/rtt/requirements.txt
```
