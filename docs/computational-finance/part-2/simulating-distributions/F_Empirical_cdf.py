import numpy as np
import matplotlib.pyplot as plt


def F_Empirical_cdf(x, p):
    index_sort = np.argsort(x)                  # MATLAB: [x_sort, index_sort] = sort(x)
    x_sort = x[index_sort]
    p_sort = p[index_sort]
    Emp_cdf = np.cumsum(p_sort)
    plt.step(x_sort, Emp_cdf, where='post')     # MATLAB: stairs(x_sort, Emp_cdf)
    return Emp_cdf
