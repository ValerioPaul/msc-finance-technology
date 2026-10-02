import numpy as np
import matplotlib.pyplot as plt
from F_Empirical_pdf import F_Empirical_pdf


# %% function F_BrownMot

def F_BrownMot(mu, sigma, m, Dt, n, x_0=0):     # x_0=0: default value, MATLAB uses nargin for this
    # n trajectories of a Brownian motion with drift mu and diffusion sigma,
    # over m steps of length Dt:  dX_k = mu*Dt + sigma*sqrt(Dt)*Z

    Z = np.random.randn(n, m)           # N(0,1) shocks: n simulations x m steps
    dX = mu * Dt + sigma * np.sqrt(Dt) * Z      # increments
    X = x_0 + np.cumsum(dX, axis=1)     # MATLAB: cumsum(dX, 2)   (axis=1: along each row)
    return X


# %% 1
n = 10000       # number of trajectories
m = 200         # number of time steps
mu = 0.1        # drift
sigma = 0.4     # volatility (diffusion)
Dt = 0.1        # time step

X = F_BrownMot(mu, sigma, m, Dt, n)     # x_0 omitted -> default 0

# %% 2
np.savetxt('BrownMot.txt', X, delimiter='\t')  # MATLAB: save('BrownMot.txt', 'X', '-ascii', '-tabs')

# %% Point 3
plt.figure(1)
plt.plot(X.T)                           # MATLAB: plot(X')   (.T is the transpose)
plt.xlabel('time')
plt.ylabel('X_t')
plt.title('Brownian motion trajectories')

# %% Point 4
for k in range(10, 191, 20):            # MATLAB: for k = 10:20:190
    plt.figure()
    F_Empirical_pdf(X[:, k-1], 100)     # MATLAB: X(:, k)   (column k is k-1 in Python)
    plt.savefig('BrownMot' + str(k) + '.jpg')   # MATLAB: print('-djpeg', ['BrownMot', num2str(k)])

plt.show()
