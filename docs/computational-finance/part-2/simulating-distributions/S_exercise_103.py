import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import uniform        # theoretical uniform distribution (pdf, cdf)
from F_Empirical_pdf import F_Empirical_pdf
from F_Empirical_cdf import F_Empirical_cdf
from F_SynteticIndices import F_SynteticIndices

# %% 1
n = 100000
a = 2
b = 7
x = a + (b - a) * np.random.rand(n)    # MATLAB: rand(n, 1), uniform on [0, 1]
x_plot = np.linspace(a, b, 1000)       # grid for the theoretical curves

# %% 2
nbins = 300
plt.figure(1)
F_Empirical_pdf(x, nbins)
plt.plot(x_plot, uniform.pdf(x_plot, a, b - a))    # MATLAB: pdf('Uniform', x_plot, a, b)   (scipy wants start and width)

# %% 3
p = np.ones(n) / n
plt.figure(2)
F_Empirical_cdf(x, p)
plt.plot(x_plot, uniform.cdf(x_plot, a, b - a))

# %% 4
E_x, Var_x, Sk_x, Ku_x = F_SynteticIndices(x)

E_x_ = a + (b - a) / 2
Var_x_ = (b - a)**2 / 12
Sk_x_ = 0
Ku_x_ = 9 / 5
print("theory:", E_x_, Var_x_, Sk_x_, Ku_x_)

plt.show()
