clear, clc

%% 1

A      = readtable('weekly_EUROSTOXX50_price_time.txt');
dates  = A{:, 1};
P      = A{:, 2:end};
RR     = diff(P) ./ P(1:end-1, :);
[T, n] = size(RR);                  % T = weeks, n = stocks

%% 2

mu = mean(RR);

%% 3

A = [-RR, -eye(T), -ones(T,1)];
b  = zeros(T, 1);
lb = [zeros(n+T, 1); -inf];

f1 = [zeros(n, 1); ones(T, 1)/(0.01*T); 1];
f5 = [zeros(n, 1); ones(T, 1)/(0.05*T); 1];

% The eta grid is SINGLE and shared: one solve fixes its lower end (using f5)
Aeq     = [ones(1,n), zeros(1,T), 0];   beq = 1;
x_min   = linprog(f5, A, b, Aeq, beq, lb, []);
eta_min = mu * x_min(1:n);
eta_max = max(mu);

%% 4

N   = 100;
eta = linspace(eta_min, eta_max, N);

%% 5

Aeq_ = [mu,        zeros(1,T), 0;
        ones(1,n), zeros(1,T), 0];

Risk_CVaR_1 = NaN(1, N);
Risk_CVaR_5 = NaN(1, N);

for k = 1:N
    beq_ = [eta(k); 1];
    [~, Risk_CVaR_1(k)] = linprog(f1, A, b, Aeq_, beq_, lb, []);   % CVaR 1%
    [~, Risk_CVaR_5(k)] = linprog(f5, A, b, Aeq_, beq_, lb, []);   % CVaR 5%
end

%% 6

figure(1);
hold on
plot(Risk_CVaR_1, eta, '--', LineWidth=2)
plot(Risk_CVaR_5, eta, '-',  LineWidth=2)
xlabel('Risk-CVaR'); ylabel('Expected return')
title('Mean-CVaR Efficient Frontier')
legend('\epsilon = 1%', '\epsilon = 5%')
print('CVaREF.jpg', '-djpeg')
