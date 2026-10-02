import numpy as np
import matplotlib.pyplot as plt
from F_Empirical_pdf import F_Empirical_pdf

# %% 1
n = 10000
m = 200
mu = 0.2
sigma = 0.2
Dt = 0.05
S_0 = 100

Z = np.random.randn(n, m)
dX = (mu - 0.5 * sigma**2) * Dt + sigma * np.sqrt(Dt) * Z   # increments of ln(S)
S_tk = S_0 * np.exp(np.cumsum(dX, axis=1))                  # S_tk = S_0 * e^(sum of the increments)

# %% 2
np.savetxt('GeoBM.txt', S_tk, delimiter='\t')

# %% 3
plt.figure(1)
plt.plot(S_tk.T)
plt.xlabel('time'); plt.ylabel('S_t'); plt.title('Geometric Brownian motion trajectories')

# %% 4
for k in range(10, 191, 20):
    plt.figure()
    F_Empirical_pdf(S_tk[:, k-1], 200)
    plt.title('Distribution at k = ' + str(k))
    plt.savefig('GeoBM' + str(k) + '.jpg')

plt.show()
