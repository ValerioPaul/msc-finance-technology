function [Call_price_M] = F_Montecarlo_def(S_0, sigma, r, T, K, n, m)
Dt = T / m
Z = randn(n, m)
dx = (r - (sigma^2 / 2)) * Dt + sigma * sqrt(Dt) * Z
S_T = S_0 * exp(cumsum(dx, 2))
Call_price_M = exp(-r * T) * mean(max(S_T - K, 0));
%Put_price = exp(-r * T) * mean(max(K - S_T, 0));
Call_price_M
plot(S_T')
print('G_MotoBrownGeom.jpg', '-djpeg')
end
