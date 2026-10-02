import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import lognorm
from F_Empirical_pdf import F_Empirical_pdf
from F_Empirical_cdf import F_Empirical_cdf
from F_SynteticIndices import F_SynteticIndices

# %% 1
n     = 10000
mu    = 2
sigma = 0.5
y = mu + sigma * np.random.randn(n)
x = np.exp(y)
x_plot = np.linspace(np.min(x), np.max(x), 1000)

# %% 2
nbins = 100
bin_width = (np.max(x) - np.min(x)) / nbins
plt.figure(1)
F_Empirical_pdf(x, nbins)
plt.plot(x_plot, lognorm.pdf(x_plot, sigma, scale=np.exp(mu)) * n * bin_width)   # MATLAB: pdf('Lognormal', x_plot, mu, sigma)   (scipy: shape sigma, scale e^mu)

# %% 3
p = np.ones(n) / n
plt.figure(2)
F_Empirical_cdf(x, p)
plt.plot(x_plot, lognorm.cdf(x_plot, sigma, scale=np.exp(mu)))

# %% 4
e_x, var_x, sk_x, ku_x = F_SynteticIndices(x)

e_x_   = np.exp(mu + sigma**2/2)
var_x_ = (np.exp(sigma**2) - 1) * np.exp(2*mu + sigma**2)
sk_x_  = (np.exp(sigma**2) + 2) * np.sqrt(np.exp(sigma**2) - 1)
ku_x_  = np.exp(4*sigma**2) + 2*np.exp(3*sigma**2) + 3*np.exp(2*sigma**2) - 3
print("theory:", e_x_, var_x_, sk_x_, ku_x_)

plt.show()
