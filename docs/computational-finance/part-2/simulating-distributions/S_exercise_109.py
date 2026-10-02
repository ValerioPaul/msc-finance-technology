import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import chi2
from F_Empirical_pdf import F_Empirical_pdf
from F_Empirical_cdf import F_Empirical_cdf
from F_SynteticIndices import F_SynteticIndices

# %% 1
n  = 100000
nu = 6
z  = np.random.randn(n, nu)
x  = np.sum(z**2, axis=1)   # MATLAB: sum(z.^2, 2)   (axis=1 sums along each row)
x_plot = np.linspace(np.min(x), np.max(x), 1000)

# %% 2
nbins = 300
bin_width = (np.max(x) - np.min(x)) / nbins
plt.figure(1)
F_Empirical_pdf(x, nbins)
plt.plot(x_plot, chi2.pdf(x_plot, nu) * n * bin_width)   # MATLAB: pdf('Chisquare', x_plot, nu)

# %% 3
p = np.ones(n) / n
plt.figure(2)
F_Empirical_cdf(x, p)
plt.plot(x_plot, chi2.cdf(x_plot, nu))

# %% 4
e_x, var_x, sk_x, ku_x = F_SynteticIndices(x)

e_x_   = nu
var_x_ = 2*nu
sk_x_  = np.sqrt(8/nu)
ku_x_  = 12/nu + 3
print("theory:", e_x_, var_x_, sk_x_, ku_x_)

plt.show()
