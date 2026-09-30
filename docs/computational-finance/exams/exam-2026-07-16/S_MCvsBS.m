clear all, clc

K = 62
S_0 = 57
r = 0.09
T = 2
sigma = 0.32
n = 10000
m = 30
%
Call_price_BS = F_formulaBS(S_0, K, r, sigma, T)
Call_price_M = F_Montecarlo_def(S_0, sigma, r, T, K, n, m)
%
% the GBM is plotted inside F_Montecarlo_def
