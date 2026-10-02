import numpy as np


# %% function F_es54

def F_es54(P, T):
    # inputs:   P := price at inception
    #           T := maturity
    # output:   i := annual interest rate

    i = (100 / P) ** (1 / T) - 1
    return i


# %% Point 2
P = np.array([99.88, 99.85, 99.76, 99.24, 97.33])
T = np.array([1/4, 1/3, 1/2, 1, 2])     # 3-months, 4-months, 6-months, 1-year, 2-years

ZCB_returns = F_es54(P, T)
print("ZCB_returns =", ZCB_returns)
