import numpy as np
from F_es47 import F_es47               # uses the function in F_es47.py (same folder), like F_es47.m

# %% Point 1
t_0 = 0                                 # by default
t = np.arange(1, 6)                     # schedule: MATLAB 1:5

C = np.array([[7, 7, 7,   7, 107],      # flows matrix
              [6, 6, 6, 106,   0],
              [0, 0, 100, 0,   0],
              [0, 0, 0,   0, 100]])

i_tilde = np.array([.05, .046, .044, .049, .052])   # non-flat yield structure

NPV, D = F_es47(t, t_0, C, i_tilde)
print("NPV =", NPV)
print("D =", D)
