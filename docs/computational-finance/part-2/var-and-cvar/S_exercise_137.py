import numpy as np
import matplotlib.pyplot as plt
from scipy.io import savemat
from F_Empirical_pdf import F_Empirical_pdf

# %% 1
n = 5
m = 1000

P0 = np.array([7, 9, 24, 19, 15])       # current prices
q = np.array([20, 20, 10, 10, 10])      # allocation (number of shares)
V0 = q @ P0                             # initial portfolio value

R = np.random.randn(m, n)               # simulated returns (standard normal)
P_T = P0 * np.exp(R)                    # future prices (log-normal): P_T = P0*e^R   (P0 is applied to every row)
V_T = P_T @ q                           # future portfolio values

PL_T = V_T - V0                         # Profit & Loss
R_T = np.log(V_T / V0)                  # future portfolio return

savemat('PortPLandRet.mat', {'PL_T': PL_T, 'R_T': R_T})

# %% 2
PL_sort = np.sort(PL_T)                 # increasing order: the first ones are the worst losses
RT_sort = np.sort(R_T)

# epsilon = 0.05
N5 = int(np.floor(0.05 * m)) + 1        # position in MATLAB numbering (51)
VaR_PL_5 = -PL_sort[N5 - 1]             # -1: Python counts from 0
VaR_RT_5 = -RT_sort[N5 - 1]
print("VaR_PL_5 =", VaR_PL_5, " VaR_RT_5 =", VaR_RT_5)

# epsilon = 0.01
N1 = int(np.floor(0.01 * m)) + 1
VaR_PL_1 = -PL_sort[N1 - 1]
VaR_RT_1 = -RT_sort[N1 - 1]
print("VaR_PL_1 =", VaR_PL_1, " VaR_RT_1 =", VaR_RT_1)

# %% 3
nbins = 40

plt.figure(1)
F_Empirical_pdf(-PL_T, nbins)
plt.axvline(VaR_PL_5, color='r', linestyle='--', linewidth=2, label='VaR 5%')   # MATLAB: xline
plt.axvline(VaR_PL_1, color='r', linestyle='-', linewidth=2, label='VaR 1%')
plt.xlabel('Loss (-PL)'); plt.ylabel('Frequency'); plt.title('Portfolio P&L distribution')
plt.legend()                            # shows the labels given above

plt.figure(2)
F_Empirical_pdf(-R_T, nbins)
plt.axvline(VaR_RT_5, color='r', linestyle='--', linewidth=2, label='VaR 5%')
plt.axvline(VaR_RT_1, color='r', linestyle='-', linewidth=2, label='VaR 1%')
plt.xlabel('Loss (-R)'); plt.ylabel('Frequency'); plt.title('Portfolio return distribution')
plt.legend()                            # shows the labels given above
plt.show()
