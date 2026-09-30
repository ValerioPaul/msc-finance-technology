clear all, clc

%% 1

A = readtable("weekly_EUROSTOXX50_price_time.txt");
times = A{:, 1};
P = A{:, [6 7]};

%% 2

Ret = diff(P) ./ P(1:end-1, :);
[n_valori, n_asset] = size(Ret);

%% 3

mu  = mean(Ret);
vol = std(Ret); % sigma = standard deviation = volatility  (sigma^2 = variance)

eta_min = min(mu);
eta_max = max(mu);
eta = linspace(eta_min, eta_max, 100);

rho = [-1 0 1];

Risk_vol = NaN(length(rho), 100);
Aeq_ = [mu; ones(1, n_asset)];
lb   = zeros(n_asset, 1);

%% 4

for j = 1:length(rho)

    Sigma = [vol(1)^2,                rho(j)*vol(1)*vol(2);
             rho(j)*vol(1)*vol(2),    vol(2)^2]; % Sigma = covariance matrix

    H = 2 * Sigma;

    for k = 1:length(eta)
        beq_ = [eta(k); 1];
        [x, Risk_var] = quadprog(H, [], [], [], Aeq_, beq_, lb, []); % Risk_var = portfolio variance (sigma^2)
        Risk_vol(j, k) = sqrt(Risk_var);
    end

end

%% 5

figure(1)
hold on
for k = 1:length(rho)
    plot(Risk_vol(k, :), eta, LineWidth=2)
end
xlabel('Risk')
ylabel('Returns')
title('Efficient frontier')
