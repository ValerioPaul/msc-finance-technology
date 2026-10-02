import numpy as np

# Data Input
z = np.array([0.021, 0.025, 0.032, 0.043])     # swap rates

# %% Point 1

# 1. square matrix where each row holds the corresponding swap rate
M = np.tile(z.reshape(-1, 1), (1, len(z)))     # MATLAB: repmat(z, 1, length(z)) with z a column
                                               # reshape(-1, 1) turns z into a column

# 2. keep the lower triangular part
A = np.tril(M)

# 3. add 1 on the main diagonal
A = A + np.eye(len(z))

# %% Point 2
v = np.linalg.solve(A, np.ones(len(z)))        # MATLAB: v = A \ ones(length(z), 1)
print("v =", v)

check = A @ v                                  # verification: should return a vector of ones
print("check =", check)

# %% Point 2 alternative
v = np.linalg.inv(A) @ np.ones(4)              # MATLAB: inv(A) * ones(4, 1)
print("v =", v)
check = A @ v
print("check =", check)
