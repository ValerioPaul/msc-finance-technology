function [C, P] = F_Montecarlo(S_0, sigma, r, T, K, n)
z = randn(n, 1);
S_T = S_0 * exp((r - 0.5*sigma^2)*T + sigma*sqrt(T) * z);
C = exp(-r*T) * mean(max(S_T - K,0))
P = exp(-r*T) * mean(max(K - S_T,0))
end
