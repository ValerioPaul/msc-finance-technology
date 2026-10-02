import numpy as np


# %% function F_es46 (in Python a function must be defined before it is used)

def F_es46(F, i, s, t):
    # INPUTS:   F := flow (cash flow amounts)
    #           i := interest rate: a number (flat) or a vector (one rate per date of s)
    #           s := the schedule (payment dates)
    #           t := times of evaluation
    # OUTPUT:   V_tF := value of the flow at each evaluation time

    F = np.array(F)
    i = np.array(i)
    s = np.array(s)

    V_tF = np.zeros(len(t))             # preallocation

    if i.size != len(s) and i.size != 1:     # only a flat curve or one rate per date is accepted
        print('%%%%% The supplied yield curve is not coherent')
        return

    for k in range(len(t)):             # for each evaluation time   (k = 0, 1, ..., len(t)-1)
        v = (1 + i) ** (-(s - t[k]))    # discount factor vector: discounts flows after t(k), compounds those before
        V_tF[k] = F @ v                 # value of the flow at time t(k)

    return V_tF


# %% Point 2
F = [5, 5, 105]                         # parameters of the problem
i = 0.05
s = [1, 2, 3]
t = [0, 1, 2, 3]

V = F_es46(F, i, s, t)
print("V =", V)
# value of the flow at each time t: 100, 105, 110.25, 115.7625

# %% Point 3
i_tilde = [0.037, 0.042, 0.051]

V_tilde = F_es46(F, i_tilde, s, t)
print("V_tilde =", V_tilde)
