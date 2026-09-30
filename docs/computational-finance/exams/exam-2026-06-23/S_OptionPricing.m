clear all, clc

%% 1
K = 90;
S_0 = 85;
r = 0.06;
T = 2;
sigma = 0.4;
N = 24;
n = 100000;
[C, P] = F_Montecarlo(S_0, sigma, r, T, K, n)
%% 2
[call_prices,put_prices, put_call_parity] = F_Binomiale(S_0, T, K, r, sigma, N)
% error: the put price does not come out
%% 3
% Black-Scholes formula
d_1 = (log(S_0 ./ K) + (r + (sigma.^2)/2) .* T) / sigma .* sqrt(T)
d_2 = d_1 - sigma .* sqrt(T)
C__ = S_0 * d_1 - K * exp(-r*T) * d_2
P__ = K * exp(-r*T)*(-d_2)- S_0*(-d_1)
