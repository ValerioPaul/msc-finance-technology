import numpy as np


def F_es59(z):
    # input  : z      := swap rate vector
    # output : v_spot := zero-coupon bond prices (discount factors)

    z = np.array(z)
    n = len(z)

    M = np.tile(z.reshape(-1, 1), (1, n))
    A = np.tril(M)
    A = A + np.eye(n)

    v_spot = np.linalg.solve(A, np.ones(n))    # MATLAB: A \ ones(length(z), 1)
    return v_spot
