import numpy as np

# %% Point 1

# Parameters
n = 5
m = 1000
epsilon = 0.05
P0 = np.array([7, 9, 24, 19, 15])
q = np.array([20, 20, 10, 10, 10])
V0 = q @ P0

# Simulation
R = np.random.randn(m, n)
P_T = np.tile(P0, (m, 1)) * np.exp(R)   # MATLAB: repmat(P0, m, 1) .* exp(R)
V_T = P_T @ q

# P&L
PL_T = V_T - V0
R_T = np.log(V_T / V0)

# Risk Measures
PL_T_sort = np.sort(PL_T)
Nepsilon = round(epsilon * m)           # 50: the quantile index must point to an element

Q_PL_T = PL_T_sort[Nepsilon - 1]        # MATLAB: PL_T_sort(Nepsilon)   (-1: Python counts from 0)

VaR_PL = -Q_PL_T
CVaR_PL = -np.mean(PL_T_sort[:Nepsilon])   # MATLAB: mean(PL_T_sort(1:Nepsilon))
print("VaR_PL =", VaR_PL)
print("CVaR_PL =", CVaR_PL)
