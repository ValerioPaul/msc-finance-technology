import numpy as np
from scipy.optimize import linprog      # same name and almost the same arguments as MATLAB

# %% Point 1
f = np.array([-5, -4, -6])

A = np.array([[1, -1, 1],
              [3,  2, 4],
              [3,  2, 0]])

b = np.array([20, 42, 30])

lb = [(0, None)] * len(f)               # x >= 0 for each variable (None = no upper bound)

res = linprog(f, A_ub=A, b_ub=b, bounds=lb)   # MATLAB: [x, fval] = linprog(f, A, b, Aeq, beq, lb, ub)
x = res.x
fval = res.fun
print("x =", x)
print("fval =", fval)
