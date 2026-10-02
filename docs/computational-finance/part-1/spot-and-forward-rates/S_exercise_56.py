import numpy as np
import matplotlib.pyplot as plt
from F_es55 import F_es55

t = np.array([0.5, 1, 1.5, 2, 2.5])            # arbitrary schedule
v = np.array([0.98, 0.96, 0.94, 0.925, 0.92])  # ZCB prices

# %% Point 1
spot_r = (1 / v) ** (1 / t) - 1                # spot interest rates
print("spot_r =", spot_r)

# %% Point 2
fwd_p, fwd_r = F_es55(v, t)
print("fwd_p =", fwd_p)
print("fwd_r =", fwd_r)

# %% Point 3
plt.plot(t, spot_r, 'r', linewidth=2)
plt.plot(t, fwd_r, 'k', linewidth=2)           # white ('-w') in the MATLAB version: black here
plt.xlabel('Time')
plt.ylabel('Rate')
plt.title('Spot and forward rates', fontsize=14)
plt.legend(['Spot Rates', 'Forward Rates'], loc='lower left', fontsize=16)
plt.show()
