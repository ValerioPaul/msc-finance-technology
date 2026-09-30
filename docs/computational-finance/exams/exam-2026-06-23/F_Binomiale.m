function [call_prices,put_prices, put_call_parity] = F_Binomiale(S_0, T, K, r, sigma, N)
% note: N is the m of the exam text

dt = T / N

% r = log(1 + i)

u = exp(sigma*sqrt(dt))

d = 1 / u

q = (exp(r*dt) - d) / (u - d)

for k = 0 : N

    nodesCall(k+1, N+1) = max(S_0 * u^k *d^(N - k) - K, 0)
    nodesPut(k+1, N+1) = max(K - S_0 * u^k *d^(N - k), 0 )

end

for j = N-1 : -1 :0
    for k = 0 : j
    nodesCall(k+1, j+1) = exp(-r*dt)* (q * nodesCall(k+2, j+2) + (1 - q)*nodesCall(k+1, j+2))
    nodesPut(k+1, j+1) = exp(-r*dt)* (q * nodesPut(k+2, j+2) + (1 - q)*nodesPut(k+1, j+2))
    end
end

call_prices = nodesCall(1,1)
put_prices = nodesPut(1,1)

put_call_parity = call_prices - S_0 + K * exp(-r*T)