import numpy as np

# Expected return and risk (variance) of an equally weighted portfolio.

# 1. Vector of expected returns (mu) for the 5 stocks
mu = np.array([0.05, 0.10, 0.15, 0.08, 0.11])

# 2. 5x5 variance-covariance matrix (Sigma)
Sigma = np.array([[ 0.10,  0.00, -0.05,  0.30, -0.70],
                  [ 0.00,  0.20,  0.15, -0.10,  0.00],
                  [-0.05,  0.15,  0.50,  0.20, -0.15],
                  [ 0.30, -0.10,  0.20,  0.30,  0.25],
                  [-0.70,  0.00, -0.15,  0.25,  0.40]])

n = len(mu)                             # MATLAB: length(mu)

# %% Point 1
# equally weighted portfolio: 20% in each of the 5 stocks
x = np.ones(n) / n
print("x =", x)

# %% Point 2
# expected return = weighted average of the expected returns
Exp_Ret = mu @ x                        # MATLAB: mu * x
print("Exp_Ret =", Exp_Ret)

# %% Point 3
# portfolio variance in matrix form
Variance = x @ Sigma @ x                # MATLAB: x' * Sigma * x   (for 1-D vectors no transpose is needed)
print("Variance =", Variance)
