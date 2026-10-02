import numpy as np
import matplotlib.pyplot as plt
from F_Empirical_pdf import F_Empirical_pdf
from F_Empirical_cdf import F_Empirical_cdf
from F_SynteticIndices import F_SynteticIndices
from F_MCmethod import F_MCmethod

# %% 1
n = 100000
nbins = 50

Z = np.random.randn(n)
p = np.ones(n) / n

# %% 2
plt.figure(1)
F_Empirical_pdf(Z, nbins)
plt.savefig('G_MCmethodIn_pdf.jpg')     # MATLAB: print('-djpeg', 'G_MCmethodIn_pdf')

plt.figure(2)
F_Empirical_cdf(Z, p)
plt.savefig('G_MCmethodIn_cdf.jpg')

# %% 3
Y = F_MCmethod(Z)

# %% 4
E_Y, Var_Y, Skew_Y, Kurt_Y = F_SynteticIndices(Y)

plt.figure(3)
F_Empirical_pdf(Y, nbins)
plt.savefig('G_MCmethodOut_pdf.tiff')

plt.figure(4)
F_Empirical_cdf(Y, p)
plt.savefig('G_MCmethodOut_cdf.tiff')

plt.show()

# %% 5
# Y is distributed as a Uniform(0,1), not as the normal Z it started from:
# flat pdf on [0,1], linear cdf, mean ~ 0.5, variance ~ 0.083, skewness ~ 0,
# kurtosis ~ 1.8. The black box phi is the standard normal CDF, and applied
# to normal samples it gives a Uniform(0,1).
