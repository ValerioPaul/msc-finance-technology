import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import norm
from F_Empirical_pdf import F_Empirical_pdf
from F_Empirical_cdf import F_Empirical_cdf
from F_SynteticIndices import F_SynteticIndices

# %% 1
n     = 100000
mu    = 1
sigma = 2
x     = mu + sigma * np.random.randn(n)
x_plot = np.linspace(np.min(x), np.max(x), 1000)

# %% 2
nbins = 300
bin_width = (np.max(x) - np.min(x)) / nbins
plt.figure(1)
F_Empirical_pdf(x, nbins)
plt.plot(x_plot, norm.pdf(x_plot, mu, sigma) * n * bin_width)   # MATLAB: pdf('Normal', x_plot, mu, sigma)

# %% 3
p = np.ones(n) / n
plt.figure(2)
F_Empirical_cdf(x, p)
plt.plot(x_plot, norm.cdf(x_plot, mu, sigma))

# %% 4
e_x, var_x, sk_x, ku_x = F_SynteticIndices(x)

e_x_   = mu
var_x_ = sigma**2
sk_x_  = 0
ku_x_  = 3
print("theory:", e_x_, var_x_, sk_x_, ku_x_)

plt.show()
