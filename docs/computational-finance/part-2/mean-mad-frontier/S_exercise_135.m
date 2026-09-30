clear all, clc

%% 1

A = readtable("weekly_EUROSTOXX50_price_time.txt");
times = A{:, 1};
P = A{:, 2:end};

%% 2

RR = diff(P) ./ P(1:end-1, :);
[T, n] = size(RR);

%% 3

mu = mean(RR);

%% 4

dev = RR - repmat(mu, T, 1); % how far each return is from its mean

f  = [zeros(1, n), ones(1, T)/T];

A = [ dev,  -eye(T);
      -dev,  -eye(T)];
b  = zeros(2 * T, 1);

lb = zeros(n + T, 1);

% minimum risk (budget constraint only, no return constraint)
Aeq = [ones(1, n), zeros(1, T)];
beq = 1;

[port_min, mad_min] = linprog(f, A, b, Aeq, beq, lb, []);
x_min   = port_min(1:n);
eta_min = mu * x_min;
eta_max = max(mu);

%% 5

N   = 100;
eta = linspace(eta_min, eta_max, N);

%% 6

Risk_MAD = NaN(1, N);

Aeq_ = [mu,          zeros(1, T);
        ones(1, n),  zeros(1, T)];

for k = 1:N
    beq_ = [eta(k); 1];
    [port_k, mad_k] = linprog(f, A, b, Aeq_, beq_, lb, []);
    Risk_MAD(k) = mad_k;
end

%% 7

figure(1)
plot(Risk_MAD, eta, LineWidth=2)
xlabel('Risk-MAD')
ylabel('Expected return')
title('Mean-MAD Efficient Frontier')
