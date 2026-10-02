import numpy as np

t = np.arange(0.5, 5.01, 0.5)           # MATLAB: t = 0.5 : 0.5 : 5   (time schedule, years)

# %% Point 1
i = 0.02                                # flat (annual) interest rate

v = (1 + i) ** -t                       # discount factor vector

# %% Point 2
i_tilde = np.array([0.008, 0.010, 0.015, 0.018, 0.025,
                    0.031, 0.037, 0.040, 0.045, 0.047])   # one rate per maturity

v_tilde = (1 + i_tilde) ** -t           # discount factor vector
print("v_tilde =", v_tilde)
