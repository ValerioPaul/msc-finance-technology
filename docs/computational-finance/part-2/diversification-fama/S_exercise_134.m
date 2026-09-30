clear all, clc

%% 1

A = readtable("weekly_MIBTEL_price_time.txt");
time = A{:, 1};
P = A{:, 2:end};

%% 2

RR = diff(P) ./ P(1:end-1, :);
[T, n] = size(RR);
Sigma = cov(RR);

%% 3

var_EW = NaN(1, n);

for k = 1:n
    x_EW = ones(k, 1) / k; % weights
    var_EW(k) = x_EW' * Sigma(1:k, 1:k) * x_EW; % portfolio variance
end

Sigma2_C = (sum(Sigma(:)) - sum(diag(Sigma))) / (n^2 - n);

%% 4

figure(1)
hold on
plot(1:n, var_EW, LineWidth=2)
plot(1:n, ones(1, n) * Sigma2_C, LineWidth=2)
xlabel('n. of assets')
ylabel('Variance')
title("Fama's Experiment")
