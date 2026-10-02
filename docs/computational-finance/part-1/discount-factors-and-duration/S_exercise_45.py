import numpy as np
from scipy.io import loadmat            # to read MATLAB .mat files

# inputs from exercise 44
t = np.arange(0.5, 5.01, 0.5)

i = 0.02
v = (1 + i) ** -t

i_tilde = np.array([0.008, 0.010, 0.015, 0.018, 0.025,
                    0.031, 0.037, 0.040, 0.045, 0.047])
v_tilde = (1 + i_tilde) ** -t

# %% Point 1
C = loadmat('Exercise_17.mat')['C']     # MATLAB: load('Exercise_17.mat')   (C = cash flows, one row per asset)

# Present Value with flat yield curve
PV_flat = C @ v                         # MATLAB: C * v'
print("PV_flat =", PV_flat)

# Present Value with non-flat yield curve
PV_nonflat = C @ v_tilde
print("PV_nonflat =", PV_nonflat)

# %% Point 2
# Duration of the five assets with a flat yield curve
D_flat = (C @ (t * v)) / (C @ v)        # numerator: present values weighted by time
print("D_flat =", D_flat)

# Duration of the five assets with a non-flat yield curve
D_nonflat = (C @ (t * v_tilde)) / (C @ v_tilde)
print("D_nonflat =", D_nonflat)

# %% Point 3
q = np.array([50, 100, 70, 80, 30])

# Duration of portfolio q with a flat yield curve
D_portq_flat = (q @ C @ (t * v)) / (q @ C @ v)
print("D_portq_flat =", D_portq_flat)

# Duration of portfolio q with a non-flat yield curve
D_portq_nonflat = (q @ C @ (t * v_tilde)) / (q @ C @ v_tilde)
print("D_portq_nonflat =", D_portq_nonflat)
