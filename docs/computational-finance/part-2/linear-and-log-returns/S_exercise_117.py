import numpy as np

# %% 1
P = np.array([10, 10.3, 10.7, 12, 14.2, 14.9, 19, 10.4, 16, 8.5])

R_lin = np.diff(P) / P[:-1]             # MATLAB: diff(P) ./ P(1:end-1)   (P[:-1] = all but the last)
print("R_lin =", R_lin)

R_log = np.diff(np.log(P))
print("R_log =", R_log)

# %% 2
t = len(P)

R_lin_ = np.zeros(t - 1)
for k in range(1, t):                   # MATLAB: for k = 2 : t
    R_lin_[k-1] = (P[k] - P[k-1]) / P[k-1]
print("R_lin_ =", R_lin_)

R_log_ = np.zeros(t - 1)
for k in range(1, t):
    R_log_[k-1] = np.log(P[k] / P[k-1])
print("R_log_ =", R_log_)
