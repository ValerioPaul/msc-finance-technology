import numpy as np

# %% 1
n = 10**6                               # MATLAB: 1e6   (10**6 is an integer, needed as a size)
m = 100
S_0 = 36.64
K = 37
r = 0.0175
T = 0.5
sigma = 0.2

# %% 2
Dt = T / m
Z = np.random.randn(n, m)
dX = (r - 0.5 * sigma**2) * Dt + sigma * np.sqrt(Dt) * Z
S_tk = S_0 * np.exp(np.cumsum(dX, axis=1))

# %% 3
S_bar = np.mean(S_tk, axis=1)           # average price of each path   (MATLAB: mean(S_tk, 2))

# %% 4
C = np.exp(-r * T) * np.mean(np.maximum(S_bar - K, 0))
P = np.exp(-r * T) * np.mean(np.maximum(K - S_bar, 0))
print("C =", C)
print("P =", P)
