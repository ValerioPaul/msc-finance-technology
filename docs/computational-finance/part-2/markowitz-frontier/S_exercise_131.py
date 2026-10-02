import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import minimize     # scipy has no quadprog: minimize does the same job
from scipy.io import savemat

# %% 1
A = np.loadtxt('weekly_EUROSTOXX50_price_time.txt')   # MATLAB: readtable(...)   (a plain table of numbers)

# %% 2
times = A[:, 0]                         # MATLAB: A{:, 1}
P = A[:, 1:]                            # MATLAB: A{:, 2:end}

# %% 3
RR = np.diff(P, axis=0) / P[:-1, :]     # MATLAB: diff(P) ./ P(1:end-1, :)   (axis=0: along the rows)

# %% 4
mu = np.mean(RR, axis=0)                # one mean per stock (column)
cov_ = np.cov(RR, rowvar=False)         # MATLAB: cov(RR)

n_valori, n_asset = RR.shape

# %% 5 - minimum risk portfolio
H = 2 * cov_
obj = lambda x: 0.5 * x @ H @ x         # what quadprog minimises: here it equals the portfolio variance
lb = [(0, None)] * n_asset              # no short selling
budget = {'type': 'eq', 'fun': lambda x: np.sum(x) - 1}   # weights sum to 1
x0 = np.ones(n_asset) / n_asset         # starting point (quadprog does not need one, minimize does)

res = minimize(obj, x0, method='SLSQP', bounds=lb, constraints=[budget], options={'ftol': 1e-12, 'maxiter': 1000})
x_min = res.x
var_min = res.fun
print("var_min =", var_min)

eta_min = mu @ x_min                    # return of the minimum risk portfolio
print("eta_min =", eta_min)

# maximum risk portfolio
eta_max = np.max(mu)
print("eta_max =", eta_max)

# %% 6
eta = np.linspace(eta_min, eta_max, 100)

# %% 7
x_ = np.zeros((n_asset, len(eta)))
var_ = np.zeros(len(eta))

for k in range(len(eta)):
    target = {'type': 'eq', 'fun': lambda x: mu @ x - eta[k]}   # MATLAB: Aeq_ = [mu; ones], beq_ = [eta(k); 1]
    res = minimize(obj, x0, method='SLSQP', bounds=lb, constraints=[budget, target], options={'ftol': 1e-12, 'maxiter': 1000})
    x_[:, k] = res.x
    var_[k] = res.fun

# %% 8
savemat('MarkRiskyAsset.mat', {'var_': var_, 'RR': RR, 'eta': eta})   # MATLAB: save('MarkRiskyAsset.mat', ...)

# %% 9
plt.figure(1)
plt.plot(var_, eta, linewidth=2)
plt.xlabel('Risk')
plt.ylabel('Returns')
plt.title('Efficient frontier')
plt.savefig('Markowitz_EF.jpg')         # MATLAB: print('Markowitz_EF.jpg', '-djpeg')
plt.show()
