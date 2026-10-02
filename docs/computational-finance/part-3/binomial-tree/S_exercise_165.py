import numpy as np


# %% function F_es165

def F_es165(T, K, S_0, i, sigma, N):
    # PRICE OF A EUROPEAN OPTION ON A BINOMIAL TREE
    # INPUTS:   T := maturity; K := strike price; S_0 := current price;
    #           i := risk free rate; sigma := volatility; N := steps
    # OUTPUTS:  Call_price, Put_price, PutcallParity (check with put-call parity)

    # CRR parametrization
    delta_t = T / N                     # length of a single step
    r = np.log(1 + i)                   # continuously compounded interest rate
    u = np.exp(sigma * np.sqrt(delta_t))    # upstate coefficient
    d = 1 / u                           # downstate coefficient
    q = (np.exp(r * delta_t) - d) / (u - d) # risk neutral probability of the upstate

    NodesCall = np.full((N + 1, N + 1), np.nan)   # MATLAB: NaN(N+1, N+1)
    NodesPut = np.full((N + 1, N + 1), np.nan)

    # payoff at maturity T (column j = N)
    # in MATLAB node (k, j) is stored in (k+1, j+1); in Python, counting from 0, it is just [k, j]
    for k in range(N + 1):              # MATLAB: for k = 0:N
        NodesCall[k, N] = max(0, S_0 * u**k * d**(N - k) - K)
        NodesPut[k, N] = max(0, K - S_0 * u**k * d**(N - k))

    # backward procedure to find the value of the option
    for j in range(N - 1, -1, -1):      # MATLAB: for j = N-1:-1:0
        for k in range(j + 1):          # MATLAB: for k = 0:j
            NodesCall[k, j] = np.exp(-r * delta_t) * (q * NodesCall[k+1, j+1] + (1 - q) * NodesCall[k, j+1])
            NodesPut[k, j] = np.exp(-r * delta_t) * (q * NodesPut[k+1, j+1] + (1 - q) * NodesPut[k, j+1])

    Call_price = NodesCall[0, 0]        # the price of a call in t=0   (MATLAB: NodesCall(1,1))
    Put_price = NodesPut[0, 0]

    # check the price of the put using the put-call parity relationship
    PutcallParity = Call_price - S_0 + K * np.exp(-r * T)

    return Call_price, Put_price, PutcallParity


# %% 1
# Inputs of the problem
T = 1           # time to maturity
K = 100         # strike price
S_0 = 100       # current price
i = 0.05        # risk free rate
sigma = 0.20    # volatility of the underlying
N = 50          # number of time steps

C, P, pcp = F_es165(T, K, S_0, i, sigma, N)
print("C =", C)
print("P =", P)
print("pcp =", pcp)
