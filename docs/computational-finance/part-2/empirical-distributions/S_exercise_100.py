import numpy as np


# %% function F_es100

def F_es100(x):
    # summary statistics: mean, variance, skewness, kurtosis

    E_x = np.mean(x)                    # expected value
    x_ = x - E_x                        # deviations from the mean

    Var_x = np.mean(x_**2)              # variance = mean of the squared deviations
    dev_x = np.sqrt(Var_x)              # standard deviation

    Skew_x = np.mean((x_ / dev_x)**3)   # skewness: standardised deviations, cubed, averaged
    Kurt_x = np.mean((x_ / dev_x)**4)   # kurtosis: same, fourth power (normal = 3)

    return E_x, Var_x, Skew_x, Kurt_x


# %% Point 1
n = 1000000
x = np.random.randn(n)

E_x, Var_x, Skew_x, Kurt_x = F_es100(x)
print("E_x =", E_x)
print("Var_x =", Var_x)
print("Skew_x =", Skew_x)
print("Kurt_x =", Kurt_x)

# alternatively, ready-made functions:
# np.var(x), scipy.stats.skew(x), scipy.stats.kurtosis(x, fisher=False)
