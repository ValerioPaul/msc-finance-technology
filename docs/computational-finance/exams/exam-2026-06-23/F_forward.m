function [forward_prices,forward_rates] = F_forward(t,v)
n = length(t);
forward_prices(1) = v(1);
for k = 2 : n
   forward_prices(:, k) = v(k) / v(k-1)
end

forward_rates(1) = (1 / forward_prices(k)) ^ (1/t(1)) - 1;
for k = 2 : n
    forward_rates(:, k) = (1 / v(k)) ^ (1 / (t(k) - t(k-1))) - 1
end
end
