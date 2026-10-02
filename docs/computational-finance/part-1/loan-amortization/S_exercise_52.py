import numpy as np


# %% function F_es52

def F_es52(S, N, i_, flag):
    # inputs: S    := debt amount
    #         N    := number of periods
    #         i_   := fixed interest rate (consistent with the payment frequency)
    #         flag := 1 = french; 2 = italian
    # output: Schedule := table of period, total payment, capital share, interest share, residual debt

    v = 1 / (1 + i_)
    time = np.arange(0, N + 1)          # MATLAB: (0:N)'

    if flag == 1:
        a = v * (1 - v**N) / (1 - v)    # annuity factor "a"
        R = S / a                       # constant total payment
        RR = np.zeros(N + 1)            # total payments (the first one, at t=0, is 0)
        RR[1:] = R
        D = np.zeros(N + 1)             # residual debt
        I = np.zeros(N + 1)             # interest share
        C = np.zeros(N + 1)             # capital share
        D[0] = S                        # residual debt at t=0   (MATLAB: D(1, 1) = S)

        for k in range(1, N + 1):       # MATLAB: for k = 2:N+1   (indices start from 0 in Python)
            I[k] = i_ * D[k-1]
            C[k] = R - I[k]
            D[k] = D[k-1] - C[k]

        Schedule = np.column_stack([time, RR, C, I, D])   # MATLAB: [time, RR, C, I, D]

    elif flag == 2:
        C = np.zeros(N + 1)             # constant principal portion
        C[1:] = S / N
        D = S - np.cumsum(C)            # residual debt
        I = np.zeros(N + 1)
        I[1:] = D[:-1] * i_             # interest share   (MATLAB: D(1:end-1) * i_)
        R = C + I                       # payments

        Schedule = np.column_stack([time, R, C, I, D])

    return Schedule


# %% Point 1
np.set_printoptions(suppress=True, precision=2)   # MATLAB: format bank (two decimals)

S = 140000
n = 20
i_ = 0.057

# annual rate converted into a semi-annual rate, because the payments are semi-annual
i_sa = (1 + i_) ** (1/2) - 1

Ammortamento_francese = F_es52(S, n, i_sa, 1)
print("Ammortamento_francese =\n", Ammortamento_francese)

Ammortamento_italiano = F_es52(S, n, i_sa, 2)
print("Ammortamento_italiano =\n", Ammortamento_italiano)
