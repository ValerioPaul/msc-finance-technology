import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import linprog

# %% 1
A = np.loadtxt('weekly_EUROSTOXX50_price_time.txt')
dates = A[:, 0]
P = A[:, 1:]
RR = np.diff(P, axis=0) / P[:-1, :]
T, n = RR.shape                         # T = weeks, n = stocks

# %% 2
mu = np.mean(RR, axis=0)

# %% 3
A = np.hstack([-RR, -np.eye(T), -np.ones((T, 1))])   # MATLAB: [-RR, -eye(T), -ones(T,1)]
b = np.zeros(T)
lb = [(0, None)] * (n + T) + [(None, None)]           # weights and excesses >= 0; threshold free

f1 = np.concatenate([np.zeros(n), np.ones(T) / (0.01 * T), [1]])
f5 = np.concatenate([np.zeros(n), np.ones(T) / (0.05 * T), [1]])

# The eta grid is single and shared: one solve fixes its lower end (using f5)
Aeq = np.concatenate([np.ones(n), np.zeros(T), [0]]).reshape(1, -1)
beq = [1]
x_min = linprog(f5, A_ub=A, b_ub=b, A_eq=Aeq, b_eq=beq, bounds=lb).x
eta_min = mu @ x_min[:n]
eta_max = np.max(mu)

# %% 4
N = 100
eta = np.linspace(eta_min, eta_max, N)

# %% 5
Aeq_ = np.vstack([np.concatenate([mu, np.zeros(T), [0]]),
                  np.concatenate([np.ones(n), np.zeros(T), [0]])])

Risk_CVaR_1 = np.zeros(N)
Risk_CVaR_5 = np.zeros(N)

for k in range(N):
    beq_ = [eta[k], 1]
    Risk_CVaR_1[k] = linprog(f1, A_ub=A, b_ub=b, A_eq=Aeq_, b_eq=beq_, bounds=lb).fun   # CVaR 1%
    Risk_CVaR_5[k] = linprog(f5, A_ub=A, b_ub=b, A_eq=Aeq_, b_eq=beq_, bounds=lb).fun   # CVaR 5%

print("CVaR 1%:", Risk_CVaR_1[0], "..", Risk_CVaR_1[-1], "  CVaR 5%:", Risk_CVaR_5[0], "..", Risk_CVaR_5[-1])

# %% 6
plt.figure(1)
plt.plot(Risk_CVaR_1, eta, '--', linewidth=2)
plt.plot(Risk_CVaR_5, eta, '-', linewidth=2)
plt.xlabel('Risk-CVaR'); plt.ylabel('Expected return')
plt.title('Mean-CVaR Efficient Frontier')
plt.legend(['epsilon = 1%', 'epsilon = 5%'])
plt.savefig('CVaREF.jpg')
plt.show()
