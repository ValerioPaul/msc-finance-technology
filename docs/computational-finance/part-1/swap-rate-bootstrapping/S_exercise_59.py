import numpy as np
from F_bootstrap import F_bootstrap

# %% 1
# see the function F_bootstrap

# %% 2

z = np.array([0.0185, 0.0223, 0.0297, 0.0313])

v = F_bootstrap(z)

vv = np.zeros(len(z))

for k in range(len(z)):                        # MATLAB: for k = 1:length(z)
    vv[k] = (1 - z[k] * np.sum(vv[:k])) / (1 + z[k])   # MATLAB: sum(vv(1:k-1))  ->  Python: vv[:k]

print("vv =", vv)

# %% 3

zz = np.zeros(len(v))

for k in range(len(v)):
    zz[k] = (1 - v[k]) / np.sum(v[:k+1])       # MATLAB: sum(v(1:k))  ->  Python: v[:k+1]

print("zz =", zz)
