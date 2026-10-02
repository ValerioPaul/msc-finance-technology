import numpy as np
import pandas as pd                     # to read Excel files
import matplotlib.pyplot as plt
from scipy.interpolate import interp1d  # linear interpolation that can also extrapolate
from F_es59 import F_es59
from F_es60 import F_es60
from F_es55 import F_es55

ndata = pd.read_excel('IRS_plain_vanilla.xlsx').to_numpy()   # MATLAB: xlsread('IRS_plain_vanilla.xlsx')

time = ndata[:, 0]                      # MATLAB: ndata(:, 1)
z = ndata[:, 1]                         # z = swap rates
z = z / 100                             # the rates in the file are in percentage

# %% Point 1
v_spot = F_es59(z)

# %% Point 3
step = 0.5                              # one point every six months
time_int = np.arange(step, time[-1] + 0.01, step)   # MATLAB: step : step : time(end)

v_spot_int = F_es60(v_spot, time, time_int)

spot_r_int = (1 / v_spot_int) ** (1 / time_int) - 1   # spot rates
fwd_p, fwd_r = F_es55(v_spot_int, time_int)           # forward prices and rates

# %% Point 4 - Graph
plt.figure(1)
plt.plot(time_int, spot_r_int, 'b', linewidth=2)
plt.plot(time_int, fwd_r, 'r', linewidth=2)
plt.xlabel('Time')
plt.ylabel('Rate')
plt.title('Spot rate and forward rate')
plt.legend(['Spot Rates', 'Forward Rates'])

# %% Point 5
# the wrong procedure on purpose: interpolate the market swap rates directly
z_int = interp1d(time, z, fill_value='extrapolate')(time_int)   # MATLAB: interp1(time, z, time_int, 'linear', 'extrap')

v_spot_int = F_es59(z_int)

spot_r_int2 = (1 / v_spot_int) ** (1 / time_int) - 1

fwd_p, fwd_r2 = F_es55(v_spot_int, time_int)

plt.figure(2)
plt.plot(time_int, spot_r_int2, 'b', linewidth=2)
plt.plot(time_int, fwd_r2, 'r', linewidth=2)
plt.xlabel('Time')
plt.ylabel('Rate')
plt.title('Spot rate and forward rate')
plt.legend(['Spot Rates', 'Forward Rates'])
plt.show()

# CONCLUSION (see the note on the page): the second chart is off mainly because
# F_es59 bootstraps the half-yearly rates as if they were annual swaps.
