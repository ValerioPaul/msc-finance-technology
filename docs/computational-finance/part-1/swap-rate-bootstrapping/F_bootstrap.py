import numpy as np


def F_bootstrap(z):
    # input:  z := swap rates
    # output: v := discount factors

    z = np.array(z)
    n = len(z)

    A = np.tile(z.reshape(-1, 1), (1, n))      # each row holds its own swap rate
    A = np.tril(A)
    A = A + np.eye(n)

    v = np.linalg.inv(A) @ np.ones(n)
    return v
