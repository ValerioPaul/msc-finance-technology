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
f = np.concatenate([np.zeros(n), [-1]])          # minimise -d  ->  maximise d (= -MaxLoss)
A_ = np.hstack([-RR, np.ones((T, 1))])           # d - sum(r_t x) <= 0  for every t
b = np.zeros(T)
lb = [(0, None)] * n + [(None, None)]            # x >= 0 (no short selling); d free

# minimum risk (budget only)
Aeq = np.concatenate([np.ones(n), [0]]).reshape(1, -1)
beq = [1]

res = linprog(f, A_ub=A_, b_ub=b, A_eq=Aeq, b_eq=beq, bounds=lb)
X0 = res.x
fo = res.fun
x_min = X0[:n]
eta_min = mu @ x_min
eta_max = np.max(mu)

# %% 5
N = 100
eta = np.linspace(eta_min, eta_max, N)

# %% 6
Risk_MaxLoss = np.zeros(N)

Aeq_ = np.vstack([np.concatenate([mu, [0]]),           # return constraint
                  np.concatenate([np.ones(n), [0]])])  # budget constraint

for k in range(N):
    beq_ = [eta[k], 1]
    res = linprog(f, A_ub=A_, b_ub=b, A_eq=Aeq_, b_eq=beq_, bounds=lb)
    Risk_MaxLoss[k] = res.fun

print("fo =", fo, " eta_min =", eta_min, " MaxLoss at the top =", Risk_MaxLoss[-1])

# %% 7
plt.figure(1)
plt.plot(Risk_MaxLoss, eta, linewidth=2)
plt.xlabel('Risk-MaxLoss')
plt.ylabel('Expected return')
plt.title('Mean-MaxLoss Efficient Frontier')
plt.show()
