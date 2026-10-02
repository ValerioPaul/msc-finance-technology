import numpy as np
from scipy.optimize import minimize     # MATLAB's fmincon

# %% Point 1
fun = lambda x: x[0] * x[1] * x[2]      # MATLAB: @(x) x(1) * x(2) * x(3)

x01 = np.array([2, 4, 8])

A = np.array([[1, 3, 4],
              [-2, -1, -1/2]])
b = np.array([0, 50])

con = {'type': 'ineq', 'fun': lambda x: b - A @ x}   # A x <= b, written as  b - A x >= 0

res = minimize(fun, x01, method='SLSQP', constraints=con)
print("x =", res.x)
print("fval =", res.fun)

# %% Point 2
x02 = np.array([-8, 0, -3])

res = minimize(fun, x02, method='SLSQP', constraints=con)
print("x =", res.x)
print("fval =", res.fun)

# Two starting points, two different "solutions": see the note on the page
# (the problem has no minimum at all).
