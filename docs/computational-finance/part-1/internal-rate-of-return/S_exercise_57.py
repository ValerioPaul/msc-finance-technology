import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import fsolve       # MATLAB's fzero: finds where a function is zero

# %% 1

x = np.array([-100, 2.5, 2.5, 102.5])
t = np.array([0/12, 6/12, 12/12, 18/12])

g = lambda v: np.sum(x * v**t)          # MATLAB: g = @(v) sum(x .* v.^(t))   (lambda = anonymous function)

v = fsolve(g, 0.5)[0]                   # MATLAB: fzero(g, 0.5)   ([0] takes the number out of the result)
print("v =", v)

IRR = (1 / v - 1) * 100
print("IRR =", IRR)

# preparation for the plot

f = lambda v: np.sum(x[1:] * v**t[1:])  # the text says to start from k = 1, so the first flow is dropped
                                        # MATLAB: x(2:end)  ->  Python: x[1:]

n = 1000
v_grid = np.linspace(0.5, 0.99, n)      # grid of discount factors
# (the MATLAB version reuses t for this grid. Not here: a Python lambda reads t when it
#  is called, not when it is created, so f would see the new t and break)

f_v = np.zeros(n)
for k in range(n):
    f_v[k] = f(v_grid[k])

y = -x[0]                               # MATLAB: -x(1)
y_line = y * np.ones(n)

# plotting
plt.figure(1)
plt.plot(v_grid, f_v, linewidth=3)
plt.plot(v_grid, y_line, linewidth=3)
plt.show()

# The intersection of f(v) and y is the discount factor v*
# that sets g(v) to zero, from which the IRR is obtained
