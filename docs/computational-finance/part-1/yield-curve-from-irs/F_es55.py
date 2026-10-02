import numpy as np


def F_es55(v, t):
    # inputs:   v := ZCB prices
    #           t := the schedule (same length as v)
    # outputs:  fwd_p := forward prices
    #           fwd_r := forward interest rates

    n = len(v)

    fwd_p = np.zeros(n)                 # preallocation
    fwd_r = np.zeros(n)

    # first element: from today, the forward is the spot
    fwd_p[0] = v[0]                     # MATLAB: fwd_p(1) = v(1)   (the first element has index 0)
    fwd_r[0] = (1 / fwd_p[0]) ** (1 / t[0]) - 1

    for k in range(1, n):               # MATLAB: for k = 2:n
        fwd_p[k] = v[k] / v[k-1]
        fwd_r[k] = (1 / fwd_p[k]) ** (1 / (t[k] - t[k-1])) - 1

    return fwd_p, fwd_r
