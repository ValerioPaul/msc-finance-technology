import numpy as np
import matplotlib.pyplot as plt

S = np.arange(60, 141)                  # MATLAB: S = 60:1:140   (the end is excluded, hence 141)

# %% Point 1 - BULL SPREAD (buy call K1, sell call K2)

K_1 = 90
K_2 = 110

c_1 = np.maximum(S - K_1, 0)            # MATLAB: max(S - K_1, 0)   (np.maximum works element by element)
c_2 = np.maximum(S - K_2, 0)

f_1 = c_1 - c_2                         # Bull Spread payoff

# the component payoffs are shifted to make the construction visible
# ('--w', white, in the MATLAB version was meant for a dark background: black here)
plt.figure(1)
plt.plot(S, c_1 + 1, '--k', linewidth=1.5)
plt.plot(S, -c_2 - 1, '--k', linewidth=1.5)
plt.plot(S, f_1, linewidth=1.5)
plt.xlabel('Price')
plt.ylabel('Payoff')
plt.title('Bull Spread')

# %% Point 2 - BEAR SPREAD (buy put K2, sell put K1)

K_1 = 90
K_2 = 110

c_1 = np.maximum(K_1 - S, 0)
c_2 = np.maximum(K_2 - S, 0)

f_2 = c_2 - c_1                         # Bear Spread payoff

plt.figure(2)
plt.plot(S, -c_1 - 1, '--k', linewidth=1.5)
plt.plot(S, c_2 + 1, '--k', linewidth=1.5)
plt.plot(S, f_2, linewidth=1.5)
plt.xlabel('Price')
plt.ylabel('Payoff')
plt.title('Bear Spread')

# %% Point 3 - BUTTERFLY SPREAD (long K1, long K3, 2 short K2)

K_1 = 90
K_3 = 110
K_2 = (K_1 + K_3) / 2

c_1 = np.maximum(S - K_1, 0)
c_2 = np.maximum(S - K_2, 0)
c_3 = np.maximum(S - K_3, 0)

f_3 = c_1 + c_3 - 2 * c_2               # Butterfly Spread payoff

plt.figure(3)
plt.plot(S, c_1 + 1, '--k', linewidth=1.5)
plt.plot(S, -2 * c_2 - 1, '--k', linewidth=1.5)
plt.plot(S, c_3 + 2, '--k', linewidth=1.5)
plt.plot(S, f_3, linewidth=1.5)
plt.ylim([-30, 30])
plt.xlabel('Price')
plt.ylabel('Payoff')
plt.title('Butterfly Spread')

# %% Point 4 - STRADDLE (call + put, same strike)

K = 100

c = np.maximum(S - K, 0)
p = np.maximum(K - S, 0)

f_4 = c + p                             # Straddle payoff

plt.figure(4)
plt.plot(S, c + 1, '--k', linewidth=1.5)
plt.plot(S, p - 1, '--k', linewidth=1.5)
plt.plot(S, f_4, linewidth=1.5)
plt.xlabel('Price')
plt.ylabel('Payoff')
plt.title('Straddle')

# %% Point 5 - STRANGLE (put K1 + call K2)

K_1 = 90
K_2 = 110

p = np.maximum(K_1 - S, 0)
c = np.maximum(S - K_2, 0)

f_5 = c + p                             # Strangle payoff

plt.figure(5)
plt.plot(S, c + 1, '--k', linewidth=1.5)
plt.plot(S, p - 1, '--k', linewidth=1.5)
plt.plot(S, f_5, linewidth=1.5)
plt.xlabel('Price')
plt.ylabel('Payoff')
plt.title('Strangle')

plt.show()
