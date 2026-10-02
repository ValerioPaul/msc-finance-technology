import numpy as np


# %% function F_es53

def F_es53(s, F, alpha, beta, gamma):
    # inputs:   s := schedule
    #           F := the flows (same length as s)
    # output:   present value of the flows

    h_sk = alpha + beta * s + gamma * s**2      # yield to maturity
    i_sk = np.exp(h_sk) - 1                     # rate of interest

    valore_attuale_flussi = F @ ((1 + i_sk) ** (-s))   # flows times discount factors
    return valore_attuale_flussi


# %% Point 1
F = np.array([6, 6, 6, 6, 106])
s = np.array([1, 2, 3, 4, 5])
alpha = 0.0024
beta = 0.0097
gamma = 0.0033

Present_value = F_es53(s, F, alpha, beta, gamma)
print("Present_value =", Present_value)
