import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import minimize

# %% 1
A = np.loadtxt('weekly_EUROSTOXX50_price_time.txt')
times = A[:, 0]
P = A[:, [5, 6]]                        # MATLAB: A{:, [6 7]}   (columns 6 and 7 are 5 and 6 in Python)

# %% 2
Ret = np.diff(P, axis=0) / P[:-1, :]
n_valori, n_asset = Ret.shape

# %% 3
mu = np.mean(Ret, axis=0)
vol = np.std(Ret, axis=0, ddof=1)       # MATLAB: std(Ret)   (ddof=1 divides by N-1, as MATLAB does)

eta_min = np.min(mu)
eta_max = np.max(mu)
eta = np.linspace(eta_min, eta_max, 100)

rho = [-1, 0, 1]

Risk_vol = np.zeros((len(rho), 100))
lb = [(0, None)] * n_asset
budget = {'type': 'eq', 'fun': lambda x: np.sum(x) - 1}

# %% 4
for j in range(len(rho)):

    Sigma = np.array([[vol[0]**2,                   rho[j] * vol[0] * vol[1]],
                      [rho[j] * vol[0] * vol[1],    vol[1]**2]])     # covariance matrix
    H = 2 * Sigma

    for k in range(len(eta)):
        target = {'type': 'eq', 'fun': lambda x: mu @ x - eta[k]}
        res = minimize(lambda x: 0.5 * x @ H @ x, np.array([0.5, 0.5]), method='SLSQP',
                       bounds=lb, constraints=[budget, target], options={'ftol': 1e-14})
        Risk_var = res.fun              # portfolio variance
        Risk_vol[j, k] = np.sqrt(max(Risk_var, 0))   # volatility (max(...,0) avoids a tiny negative rounding)

# %% 5
plt.figure(1)
for k in range(len(rho)):
    plt.plot(Risk_vol[k, :], eta, linewidth=2)
plt.xlabel('Risk')
plt.ylabel('Returns')
plt.title('Efficient frontier')
plt.show()
