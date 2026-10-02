import numpy as np
import matplotlib.pyplot as plt

# %% 1
A = np.loadtxt('weekly_MIBTEL_price_time.txt')
time = A[:, 0]
P = A[:, 1:]

# %% 2
RR = np.diff(P, axis=0) / P[:-1, :]
T, n = RR.shape
Sigma = np.cov(RR, rowvar=False)

# %% 3
var_EW = np.zeros(n)

for k in range(1, n + 1):               # k = number of stocks in the portfolio, 1..n
    x_EW = np.ones(k) / k               # weights
    var_EW[k-1] = x_EW @ Sigma[:k, :k] @ x_EW   # MATLAB: x_EW' * Sigma(1:k, 1:k) * x_EW

Sigma2_C = (np.sum(Sigma) - np.trace(Sigma)) / (n**2 - n)   # average covariance (trace = sum of the diagonal)
print("var_EW(1) =", var_EW[0], " var_EW(n) =", var_EW[-1], " Sigma2_C =", Sigma2_C)

# %% 4
plt.figure(1)
plt.plot(np.arange(1, n + 1), var_EW, linewidth=2)
plt.plot(np.arange(1, n + 1), np.ones(n) * Sigma2_C, linewidth=2)
plt.xlabel('n. of assets')
plt.ylabel('Variance')
plt.title("Fama's Experiment")
plt.show()
