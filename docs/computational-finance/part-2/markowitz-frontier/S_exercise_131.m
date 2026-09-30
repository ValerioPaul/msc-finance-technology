clear all, clc

%% 1

A = readtable('weekly_EUROSTOXX50_price_time.txt');

%% 2

times = A{:, 1};
P = A{:, 2:end};

%% 3

RR = diff(P) ./ P(1:end-1, :);

%% 4

mu = mean(RR);
cov_ = cov(RR);
%
[n_valori, n_asset] = size(RR);
%

%% 5

% minimum risk portfolio

H = 2 * cov_;
Aeq = ones(1, n_asset);
beq = 1;
lb = zeros(n_asset, 1);

[x_min, var_min] = quadprog(H,[],[],[],Aeq,beq,lb,[])

eta_min = mu * x_min % return of the minimum risk portfolio

% maximum risk portfolio

eta_max = max(mu)

%% 6

eta = linspace(eta_min, eta_max, 100);

%% 7

options = optimset(MaxIter=1.e7, TolFun=1.e-10, TolX=1.e-10)

Aeq_ = [mu; ones(1, n_asset)]

for k = 1 : length(eta)
    beq_ = [eta(k) ; 1]
    [x_(:, k), var_(:, k)] = quadprog(H,[],[],[],Aeq_,beq_,lb,[],[],options)
end

%% 8

 save('MarkRiskyAsset.mat','var_', 'RR', 'eta')

%% 9

figure(1)
plot(var_, eta, lineWidth=2)
xlabel('Risk')
ylabel('Returns')
title('Efficient frontier')
print('Markowitz_EF.jpg','-djpeg')
