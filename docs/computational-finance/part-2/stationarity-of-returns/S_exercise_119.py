import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from scipy.stats import skew, kurtosis
from F_es99 import F_es99
from F_es100 import F_es100

np.set_printoptions(suppress=True)     # print numbers as 13.04, not 1.304e+01

# The stocks of exercise 119 are not in DowJones_price.xlsx: AAPL, JPM, CVX, JNJ are used.

# %% Point 1 - Import and returns

T = pd.read_excel("DowJones_price.xlsx")       # MATLAB: readtable("DowJones_price.xlsx")

# --- Prices ---
AAPL_prices = T['AAPL.OQ'].to_numpy()          # MATLAB: T{:, 'AAPL_OQ'}
                                               # (the column is called AAPL.OQ: MATLAB turns the dot into _)
JPM_prices  = T['JPM.N'].to_numpy()
CVX_prices  = T['CVX.N'].to_numpy()
JNJ_prices  = T['JNJ.N'].to_numpy()

# --- Linear returns ---
AAPL_returns = np.diff(AAPL_prices) / AAPL_prices[:-1]
JPM_returns  = np.diff(JPM_prices)  / JPM_prices[:-1]
CVX_returns  = np.diff(CVX_prices)  / CVX_prices[:-1]
JNJ_returns  = np.diff(JNJ_prices)  / JNJ_prices[:-1]

# --- Full returns matrix, saved to file ---
Returns = np.column_stack([AAPL_returns, JPM_returns, CVX_returns, JNJ_returns])
pd.DataFrame(Returns).to_excel('DowJones_returns.xlsx', index=False, header=False)   # MATLAB: writematrix

# %% Point 2 - Plot of the returns
plt.figure(1)
plt.plot(AAPL_returns)
plt.title('AAPL - Apple'); plt.ylabel('Linear Returns'); plt.xlabel('Days')
plt.figure(2)
plt.plot(JPM_returns)
plt.title('JPM - JP Morgan'); plt.ylabel('Linear Returns'); plt.xlabel('Days')
plt.figure(3)
plt.plot(CVX_returns)
plt.title('CVX - Chevron'); plt.ylabel('Linear Returns'); plt.xlabel('Days')
plt.figure(4)
plt.plot(JNJ_returns)
plt.title('JNJ - J&J'); plt.ylabel('Linear Returns'); plt.xlabel('Days')

# %% Point 3 - Descriptive statistics (one value per column = per asset)

Exp_returns = np.mean(Returns, axis=0)          # MATLAB: mean(Returns, 1)   (axis=0 = down the rows)
Std         = np.std(Returns, axis=0)           # MATLAB: std(Returns, 1)    (divides by N)
Skew        = skew(Returns, axis=0)             # MATLAB: skewness(Returns, 1)
Kurt        = kurtosis(Returns, axis=0, fisher=False)   # MATLAB: kurtosis(Returns, 1)   (normal = 3)
Sigma       = np.cov(Returns, rowvar=False)     # MATLAB: cov(Returns)   (rowvar=False: columns are the variables)

print("Exp_returns =", Exp_returns)
print("Std =", Std)
print("Skew =", Skew)
print("Kurt =", Kurt)

# %% Point 4 - Stationarity analysis
# Split: Period 1 = 2006-2015 (2513 obs) | Period 2 = 2016-2026 (2576 obs)

split   = 2513
split_r = split - 1                             # there is one return fewer than prices

# --- Split prices ---   (MATLAB: x(1:split) -> Python: x[:split];  x(split+1:end) -> x[split:])
AAPL_p1 = AAPL_prices[:split];   AAPL_p2 = AAPL_prices[split:]
JPM_p1 = JPM_prices[:split];    JPM_p2 = JPM_prices[split:]
CVX_p1 = CVX_prices[:split];    CVX_p2 = CVX_prices[split:]
JNJ_p1 = JNJ_prices[:split];    JNJ_p2 = JNJ_prices[split:]

# --- Split returns ---
AAPL_r1 = AAPL_returns[:split_r];   AAPL_r2 = AAPL_returns[split_r:]
JPM_r1 = JPM_returns[:split_r];    JPM_r2 = JPM_returns[split_r:]
CVX_r1 = CVX_returns[:split_r];    CVX_r2 = CVX_returns[split_r:]
JNJ_r1 = JNJ_returns[:split_r];    JNJ_r2 = JNJ_returns[split_r:]

# %% 4.1 PDF of the prices

nbins_p = 50

plt.figure(5)
plt.subplot(1, 2, 1); F_es99(AAPL_p1, nbins_p); plt.title('AAPL - Prices PDF 2006-2015'); plt.xlabel('Price'); plt.ylabel('Frequency')
plt.subplot(1, 2, 2); F_es99(AAPL_p2, nbins_p); plt.title('AAPL - Prices PDF 2016-2026'); plt.xlabel('Price'); plt.ylabel('Frequency')
plt.suptitle('AAPL - Price Distribution', fontsize=14, fontweight='bold')   # MATLAB: sgtitle

plt.figure(6)
plt.subplot(1, 2, 1); F_es99(JPM_p1, nbins_p); plt.title('JPM - Prices PDF 2006-2015'); plt.xlabel('Price'); plt.ylabel('Frequency')
plt.subplot(1, 2, 2); F_es99(JPM_p2, nbins_p); plt.title('JPM - Prices PDF 2016-2026'); plt.xlabel('Price'); plt.ylabel('Frequency')
plt.suptitle('JPM - Price Distribution', fontsize=14, fontweight='bold')   # MATLAB: sgtitle

plt.figure(7)
plt.subplot(1, 2, 1); F_es99(CVX_p1, nbins_p); plt.title('CVX - Prices PDF 2006-2015'); plt.xlabel('Price'); plt.ylabel('Frequency')
plt.subplot(1, 2, 2); F_es99(CVX_p2, nbins_p); plt.title('CVX - Prices PDF 2016-2026'); plt.xlabel('Price'); plt.ylabel('Frequency')
plt.suptitle('CVX - Price Distribution', fontsize=14, fontweight='bold')   # MATLAB: sgtitle

plt.figure(8)
plt.subplot(1, 2, 1); F_es99(JNJ_p1, nbins_p); plt.title('JNJ - Prices PDF 2006-2015'); plt.xlabel('Price'); plt.ylabel('Frequency')
plt.subplot(1, 2, 2); F_es99(JNJ_p2, nbins_p); plt.title('JNJ - Prices PDF 2016-2026'); plt.xlabel('Price'); plt.ylabel('Frequency')
plt.suptitle('JNJ - Price Distribution', fontsize=14, fontweight='bold')   # MATLAB: sgtitle

# %% 4.2 Summary statistics of the prices

E_AAPL_p1, Var_AAPL_p1, Skew_AAPL_p1, Kurt_AAPL_p1 = F_es100(AAPL_p1)
E_JPM_p1, Var_JPM_p1, Skew_JPM_p1, Kurt_JPM_p1 = F_es100(JPM_p1)
E_CVX_p1, Var_CVX_p1, Skew_CVX_p1, Kurt_CVX_p1 = F_es100(CVX_p1)
E_JNJ_p1, Var_JNJ_p1, Skew_JNJ_p1, Kurt_JNJ_p1 = F_es100(JNJ_p1)

E_AAPL_p2, Var_AAPL_p2, Skew_AAPL_p2, Kurt_AAPL_p2 = F_es100(AAPL_p2)
E_JPM_p2, Var_JPM_p2, Skew_JPM_p2, Kurt_JPM_p2 = F_es100(JPM_p2)
E_CVX_p2, Var_CVX_p2, Skew_CVX_p2, Kurt_CVX_p2 = F_es100(CVX_p2)
E_JNJ_p2, Var_JNJ_p2, Skew_JNJ_p2, Kurt_JNJ_p2 = F_es100(JNJ_p2)

print("prices (mean, variance, skewness, kurtosis), period 1 and period 2:")
print("AAPL", np.round([E_AAPL_p1, Var_AAPL_p1, Skew_AAPL_p1, Kurt_AAPL_p1], 2), np.round([E_AAPL_p2, Var_AAPL_p2, Skew_AAPL_p2, Kurt_AAPL_p2], 2))
print("JPM ", np.round([E_JPM_p1, Var_JPM_p1, Skew_JPM_p1, Kurt_JPM_p1], 2), np.round([E_JPM_p2, Var_JPM_p2, Skew_JPM_p2, Kurt_JPM_p2], 2))
print("CVX ", np.round([E_CVX_p1, Var_CVX_p1, Skew_CVX_p1, Kurt_CVX_p1], 2), np.round([E_CVX_p2, Var_CVX_p2, Skew_CVX_p2, Kurt_CVX_p2], 2))
print("JNJ ", np.round([E_JNJ_p1, Var_JNJ_p1, Skew_JNJ_p1, Kurt_JNJ_p1], 2), np.round([E_JNJ_p2, Var_JNJ_p2, Skew_JNJ_p2, Kurt_JNJ_p2], 2))

# %% 4.3 PDF of the returns

nbins_r = 100

plt.figure(9)
plt.subplot(1, 2, 1); F_es99(AAPL_r1, nbins_r); plt.title('AAPL - Returns PDF 2006-2015'); plt.xlabel('Return'); plt.ylabel('Frequency')
plt.subplot(1, 2, 2); F_es99(AAPL_r2, nbins_r); plt.title('AAPL - Returns PDF 2016-2026'); plt.xlabel('Return'); plt.ylabel('Frequency')
plt.suptitle('AAPL - Returns Distribution', fontsize=14, fontweight='bold')

plt.figure(10)
plt.subplot(1, 2, 1); F_es99(JPM_r1, nbins_r); plt.title('JPM - Returns PDF 2006-2015'); plt.xlabel('Return'); plt.ylabel('Frequency')
plt.subplot(1, 2, 2); F_es99(JPM_r2, nbins_r); plt.title('JPM - Returns PDF 2016-2026'); plt.xlabel('Return'); plt.ylabel('Frequency')
plt.suptitle('JPM - Returns Distribution', fontsize=14, fontweight='bold')

plt.figure(11)
plt.subplot(1, 2, 1); F_es99(CVX_r1, nbins_r); plt.title('CVX - Returns PDF 2006-2015'); plt.xlabel('Return'); plt.ylabel('Frequency')
plt.subplot(1, 2, 2); F_es99(CVX_r2, nbins_r); plt.title('CVX - Returns PDF 2016-2026'); plt.xlabel('Return'); plt.ylabel('Frequency')
plt.suptitle('CVX - Returns Distribution', fontsize=14, fontweight='bold')

plt.figure(12)
plt.subplot(1, 2, 1); F_es99(JNJ_r1, nbins_r); plt.title('JNJ - Returns PDF 2006-2015'); plt.xlabel('Return'); plt.ylabel('Frequency')
plt.subplot(1, 2, 2); F_es99(JNJ_r2, nbins_r); plt.title('JNJ - Returns PDF 2016-2026'); plt.xlabel('Return'); plt.ylabel('Frequency')
plt.suptitle('JNJ - Returns Distribution', fontsize=14, fontweight='bold')

# %% 4.4 Summary statistics of the returns

E_AAPL_r1, Var_AAPL_r1, Skew_AAPL_r1, Kurt_AAPL_r1 = F_es100(AAPL_r1)
E_JPM_r1, Var_JPM_r1, Skew_JPM_r1, Kurt_JPM_r1 = F_es100(JPM_r1)
E_CVX_r1, Var_CVX_r1, Skew_CVX_r1, Kurt_CVX_r1 = F_es100(CVX_r1)
E_JNJ_r1, Var_JNJ_r1, Skew_JNJ_r1, Kurt_JNJ_r1 = F_es100(JNJ_r1)

E_AAPL_r2, Var_AAPL_r2, Skew_AAPL_r2, Kurt_AAPL_r2 = F_es100(AAPL_r2)
E_JPM_r2, Var_JPM_r2, Skew_JPM_r2, Kurt_JPM_r2 = F_es100(JPM_r2)
E_CVX_r2, Var_CVX_r2, Skew_CVX_r2, Kurt_CVX_r2 = F_es100(CVX_r2)
E_JNJ_r2, Var_JNJ_r2, Skew_JNJ_r2, Kurt_JNJ_r2 = F_es100(JNJ_r2)

print("returns (mean x1e-4, variance x1e-4, skewness, kurtosis), period 1 and period 2:")
print("AAPL", np.round([E_AAPL_r1*1e4, Var_AAPL_r1*1e4, Skew_AAPL_r1, Kurt_AAPL_r1], 2), np.round([E_AAPL_r2*1e4, Var_AAPL_r2*1e4, Skew_AAPL_r2, Kurt_AAPL_r2], 2))
print("JPM ", np.round([E_JPM_r1*1e4, Var_JPM_r1*1e4, Skew_JPM_r1, Kurt_JPM_r1], 2), np.round([E_JPM_r2*1e4, Var_JPM_r2*1e4, Skew_JPM_r2, Kurt_JPM_r2], 2))
print("CVX ", np.round([E_CVX_r1*1e4, Var_CVX_r1*1e4, Skew_CVX_r1, Kurt_CVX_r1], 2), np.round([E_CVX_r2*1e4, Var_CVX_r2*1e4, Skew_CVX_r2, Kurt_CVX_r2], 2))
print("JNJ ", np.round([E_JNJ_r1*1e4, Var_JNJ_r1*1e4, Skew_JNJ_r1, Kurt_JNJ_r1], 2), np.round([E_JNJ_r2*1e4, Var_JNJ_r2*1e4, Skew_JNJ_r2, Kurt_JNJ_r2], 2))

plt.show()

# Conclusion: prices are not stationary (mean, variance and shape change between the
# periods); returns are approximately stationary, with persistent fat tails.
