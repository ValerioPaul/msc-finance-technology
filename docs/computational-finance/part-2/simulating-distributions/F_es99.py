import matplotlib.pyplot as plt


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
