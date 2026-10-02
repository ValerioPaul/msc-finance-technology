import numpy as np
from scipy.special import erf          # MATLAB's erf


def F_MCmethod(Z):
    Y = 1/2 * (1 + erf(Z / np.sqrt(2)))
    return Y
