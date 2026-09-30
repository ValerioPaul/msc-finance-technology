clear all, clc

%% 1

A = readtable('weekly_EUROSTOXX50_price_time.txt');
times = A{:, 1};
P = A{:, 2:end};

%% 2

RR = diff(P) ./ P(1:end-1, :);
[T, n] = size(RR);

%% 3

mu = mean(RR);

%% 4

f  = [zeros(1, n), -1];        % minimise -d  ->  maximise d (= -MaxLoss)
A_ = [-RR, ones(T, 1)];        % d - sum(r_t x) <= 0  for every t
b  = zeros(T, 1);
lb = [zeros(n, 1); -inf];      % x >= 0 (no short selling); d free
ub = [];

% minimum risk (budget only)
Aeq = [ones(1, n), 0];
beq = 1;

[X0, fo] = linprog(f, A_, b, Aeq, beq, lb, ub);
x_min   = X0(1:n);
eta_min = mu * x_min;
eta_max = max(mu);

%% 5

N   = 100;
eta = linspace(eta_min, eta_max, N);

%% 6

Risk_MaxLoss = NaN(1, N);

Aeq_ = [mu,         0;          % return constraint
        ones(1, n), 0];         % budget constraint

for k = 1:N
    beq_ = [eta(k); 1];
    [X_star, fo_star] = linprog(f, A_, b, Aeq_, beq_, lb, []);
    Risk_MaxLoss(k) = fo_star;
end

%% 7

figure(1)
plot(Risk_MaxLoss, eta, LineWidth=2)
xlabel('Risk-MaxLoss')
ylabel('Expected return')
title('Mean-MaxLoss Efficient Frontier')
