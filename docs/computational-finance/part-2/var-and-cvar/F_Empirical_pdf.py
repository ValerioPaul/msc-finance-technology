import matplotlib.pyplot as plt


def F_Empirical_pdf(y, nbins):
    # histogram of the sample y with nbins bars
    counts, edges, bars = plt.hist(y, nbins)    # MATLAB: [counts, centers] = hist(y, bins); bar(centers, counts)
    return counts
