clear all, clc

%% 1

n = 10000;
T = 1;
sigma = 0.2;
S_0 = 100;
K = 100;
r = 0.05;

[call_price, put_price] = F_MonteCarlo(S_0, K, r, sigma, T, n)


function [C, P] = F_MonteCarlo(S_0, K, r, sigma, T, n)
% European call/put pricing by Monte Carlo, simulating the price at maturity S_T
% with a GBM under the risk-neutral measure Q (drift = r, not mu).
% INPUT:  S_0 current price, K strike, r rate, sigma vol, T maturity, n simulations.
% OUTPUT: C call price, P put price.

Z   = randn(n, 1);                                    % one shock per simulation
S_T = S_0 * exp((r - 0.5*sigma^2)*T + sigma*sqrt(T)*Z);  % price at maturity (p. 227)

payoff_call = max(S_T - K, 0);                        % call payoff at maturity
payoff_put  = max(K - S_T, 0);                        % put payoff at maturity

C = exp(-r*T) * mean(payoff_call);                    % discounted mean = call price
P = exp(-r*T) * mean(payoff_put);                     % discounted mean = put price

end
