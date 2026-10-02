import numpy as np


# %% function F_MonteCarlo

def F_MonteCarlo(S_0, K, r, sigma, T, n):
    # European call/put pricing by Monte Carlo, simulating the price at maturity S_T
    # with a GBM under the risk-neutral measure Q (drift = r, not mu).

    Z = np.random.randn(n)              # one shock per simulation
    S_T = S_0 * np.exp((r - 0.5 * sigma**2) * T + sigma * np.sqrt(T) * Z)   # price at maturity

    payoff_call = np.maximum(S_T - K, 0)    # call payoff at maturity
    payoff_put = np.maximum(K - S_T, 0)     # put payoff at maturity

    C = np.exp(-r * T) * np.mean(payoff_call)   # discounted mean = call price
    P = np.exp(-r * T) * np.mean(payoff_put)    # discounted mean = put price
    return C, P


# %% 1
n = 10000
T = 1
sigma = 0.2
S_0 = 100
K = 100
r = 0.05

call_price, put_price = F_MonteCarlo(S_0, K, r, sigma, T, n)
print("call_price =", call_price)
print("put_price =", put_price)
