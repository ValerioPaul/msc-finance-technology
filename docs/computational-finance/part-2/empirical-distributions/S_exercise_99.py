import numpy as np
import matplotlib.pyplot as plt


# %% function F_es99

def F_es99(Y, nbins):
    # Histogram of a pdf, given a vector of random outcomes
    # inputs:   Y     = vector of random outcomes
    #           nbins = number of bars
    # outputs:  xx = location (centre) of each bar
    #           N  = number of elements in each bar

    N, edges, bars = plt.hist(Y, nbins)     # MATLAB: [N, xx] = hist(Y, binc); bar(xx, N)
    xx = (edges[:-1] + edges[1:]) / 2       # centre of each bar
    # (MATLAB's hist puts the centres of the first and last bar on min(Y) and max(Y);
    #  plt.hist puts the edges there, so the bars are slightly different)

    plt.title('empirical probability density function')
    return xx, N


# %% Point 1
n = 100000
y = np.random.randn(n)                  # MATLAB: randn(n, 1)
nbins = 4000
xx, N = F_es99(y, nbins)

plt.show()

# The logic in three steps:
# 1) find the boundaries: min and max of the data
# 2) split that space into nbins equal parts
# 3) count the values in each part and draw the bars
# The chart shows the empirical distribution; with many samples it converges
# to the theoretical one (law of large numbers).
