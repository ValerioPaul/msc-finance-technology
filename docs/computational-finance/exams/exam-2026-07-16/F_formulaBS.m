function [Call_price_BS] = F_formulaBS(S_0, K, r, sigma, T)
d1 = (log(S_0 ./ K) + (r + sigma.^2 /2) .* T) ./ (sigma .* sqrt(T))
d2 = d1 - sigma .* sqrt(T)
%
nd1 = 1/2 * (1 + erf(d1 / sqrt(2)))
nd2 = 1/2 * ( 1 + erf(d2 / sqrt(2)))
%
Call_price_BS = S_0 .* nd1 - K .* exp(-r * T) .* nd2
end
