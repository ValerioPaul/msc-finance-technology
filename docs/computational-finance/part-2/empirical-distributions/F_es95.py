import numpy as np
import matplotlib.pyplot as plt


def F_es95(x, p):
    # The CDF must be computed in increasing order of x: sort first.
    # inputs:    x := values of the random variable
    #            p := probabilities linked to each element of x
    # outputs:   x_sort  := x sorted in increasing order
    #            Emp_cdf := cumulative probabilities associated with x_sort

    x = np.array(x)
    p = np.array(p)

    Ind_sort = np.argsort(x)            # MATLAB: [x_sort, Ind_sort] = sort(x)   (argsort gives the positions)
    x_sort = x[Ind_sort]

    p_sort = p[Ind_sort]                # reorder the probabilities to follow x_sort

    Emp_cdf = np.cumsum(p_sort)         # cumulative sum of the probabilities

    plt.step(x_sort, Emp_cdf, where='post', linewidth=2)   # MATLAB: stairs (a CDF is piecewise constant)
    plt.title('Empirical Cumulative Distribution Function')
    plt.xlabel('x')
    plt.ylabel('F_X(x)')

    return x_sort, Emp_cdf
