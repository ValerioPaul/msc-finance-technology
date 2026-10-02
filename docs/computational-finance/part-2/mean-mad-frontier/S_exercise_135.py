import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import linprog

# %% 1
A = np.loadtxt('weekly_EUROSTOXX50_price_time.txt')
times = A[:, 0]
P = A[:, 1:]

# %% 2
RR = np.diff(P, axis=0) / P[:-1, :]
T, n = RR.shape

# %% 3
mu = np.mean(RR, axis=0)

# %% 4
dev = RR - np.tile(mu, (T, 1))          # how far each return is from its mean

f = np.concatenate([np.zeros(n), np.ones(T) / T])   # MATLAB: [zeros(1, n), ones(1, T)/T]

A = np.block([[ dev, -np.eye(T)],       # MATLAB: [ dev, -eye(T); -dev, -eye(T)]
              [-dev, -np.eye(T)]])
b = np.zeros(2 * T)

lb = [(0, None)] * (n + T)

# minimum risk (budget constraint only)
Aeq = np.concatenate([np.ones(n), np.zeros(T)]).reshape(1, -1)   # one row
beq = [1]

res = linprog(f, A_ub=A, b_ub=b, A_eq=Aeq, b_eq=beq, bounds=lb)
port_min = res.x
mad_min = res.fun
x_min = port_min[:n]                    # MATLAB: port_min(1:n)
eta_min = mu @ x_min
eta_max = np.max(mu)

# %% 5
N = 100
eta = np.linspace(eta_min, eta_max, N)

# %% 6
Risk_MAD = np.zeros(N)

Aeq_ = np.vstack([np.concatenate([mu, np.zeros(T)]),           # MATLAB: [mu, zeros(1, T);
                  np.concatenate([np.ones(n), np.zeros(T)])])  #          ones(1, n), zeros(1, T)]

for k in range(N):
    beq_ = [eta[k], 1]
    res = linprog(f, A_ub=A, b_ub=b, A_eq=Aeq_, b_eq=beq_, bounds=lb)
    Risk_MAD[k] = res.fun

print("mad_min =", mad_min, " eta_min =", eta_min, " MAD at the top =", Risk_MAD[-1])

# %% 7
plt.figure(1)
plt.plot(Risk_MAD, eta, linewidth=2)
plt.xlabel('Risk-MAD')
plt.ylabel('Expected return')
plt.title('Mean-MAD Efficient Frontier')
plt.show()
