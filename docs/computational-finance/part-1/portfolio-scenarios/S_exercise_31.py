import numpy as np
import matplotlib.pyplot as plt

# %% Point 1

# input of daily return matrix R
R = np.array([[ 0.03,  0.05,  0.04,  0.02,  0.05],
              [ 0.05,  0.06,  0.05,  0.03,  0.08],
              [-0.04, -0.02,  0.01, -0.01, -0.10]])

n, m = R.shape                          # n (rows) are the scenarios, m (columns) are the stocks

P_0 = np.array([10, 20, 15, 20, 25])    # current price vector (at time 0)

P = np.tile(P_0, (n, 1)) * (1 + R)      # MATLAB: repmat(P_0, n, 1) .* (1 + R)   (* is element by element)

q = np.array([1000, 800, 1100, 700, 500])   # number of shares held for each stock

V_q = P @ q                             # value of the portfolio for each scenario   (@ is the matrix product, MATLAB's *)

V_0 = P_0 @ q                           # current portfolio value

R_q = (V_q / V_0) - 1                   # portfolio return for each scenario

# %% Point 2 - Monte Carlo simulation

n_MC = 100                              # scenarios of the Monte Carlo simulation

R_MC = np.random.randn(n_MC, m) / 10    # 100 x 5 matrix of normal returns, 10% volatility

P_MC = np.tile(P_0, (n_MC, 1)) * (1 + R_MC)

V_MC_q = P_MC @ q

R_MC_q = (V_MC_q / V_0) - 1

# %% extra: histogram of the simulated returns

plt.figure()
plt.hist(R_MC_q, 15)                    # 15 bins
plt.title('Portfolio return distribution (Monte Carlo simulation)')
plt.xlabel('Portfolio return (e.g. 0.05 = 5%)')
plt.ylabel('Frequency (number of scenarios out of 100)')
plt.grid(True)

# %% extra: 95% Value at Risk

livello_confidenza = 95
percentile_var = 100 - livello_confidenza

VaR_95_perc = np.percentile(R_MC_q, percentile_var)     # MATLAB: prctile
print(f"95% VaR of the portfolio: {VaR_95_perc * 100:.2f}%")   # f"...{x:.2f}..." is MATLAB's fprintf('%.2f', x)

VaR_95_valore = V_0 * VaR_95_perc
print(f"Estimated maximum loss at 95%: {VaR_95_valore:.2f} EUR")

plt.show()
