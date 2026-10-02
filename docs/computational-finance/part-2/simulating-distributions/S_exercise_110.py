import numpy as np
import matplotlib.pyplot as plt
from F_es99 import F_es99
from F_es95 import F_es95
from F_es100 import F_es100

# %% Point 1
n = 1000000         # number of observations to simulate
nu = 5              # degrees of freedom of the Student t
mu = 0              # mean (affine transformation parameter)
sigma = 1           # scale (affine transformation parameter)

# building the Student t
Z_ = np.random.randn(n, nu + 1)
Z = Z_[:, 0]                            # MATLAB: Z_(:, 1)
Q = np.sum(Z_[:, 1:]**2, axis=1)        # MATLAB: sum(Z_(:, 2:end).^2, 2)
T = Z / np.sqrt(Q / nu)
X = mu + sigma * T                      # affine transformation

# %% Point 2 - PDF
nbins = 100
plt.figure(1)
xx, N = F_es99(X, nbins)

# %% Point 3 - CDF
plt.figure(2)
p = np.ones(n) / n                      # equal weight 1/n for each observation
x_sort, F_x_emp = F_es95(X, p)

# %% Point 4 - empirical vs theoretical summary statistics
E_x, Var_x, Skew_x, Kurt_x = F_es100(X)
print("E_x =", E_x, " Var_x =", Var_x, " Skew_x =", Skew_x, " Kurt_x =", Kurt_x)

t_E_x = mu
t_Var_X = (nu / (nu - 2)) * sigma**2
t_Skew_x = 0
t_Kurt_x = (6 / (nu - 4)) + 3
print("theory:", t_E_x, t_Var_X, t_Skew_x, t_Kurt_x)

plt.show()
