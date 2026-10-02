import numpy as np
from scipy.optimize import minimize     # scipy has no quadprog: minimize does the same job

# %% 1
H = np.array([[2, -1],
              [-1, 2]])                 # squared terms: coefficient times 2; cross term as it is
f = np.array([-2, -6])                  # coefficients of the linear part

A = np.array([[1, 1],
              [-1, 2],
              [2, 1]])                  # inequality constraints  A x <= b
b = np.array([2, 2, 3])

lb = [(0, None)] * 2                    # x >= 0

obj = lambda x: 0.5 * x @ H @ x + f @ x     # the quadratic objective that quadprog minimises
con = {'type': 'ineq', 'fun': lambda x: b - A @ x}   # scipy wants constraints written as  (something) >= 0

res = minimize(obj, np.zeros(2), method='SLSQP', bounds=lb, constraints=con)
x = res.x
fval = res.fun
print("x =", x)
print("fval =", fval)
