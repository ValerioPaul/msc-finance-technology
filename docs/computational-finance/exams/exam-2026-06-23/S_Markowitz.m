clear all, clc

%% 1
A = readtable('EuroStoxx50.xlsx');
%% 2
t = A{:, 1};
P = A{:, 2:end};
P_cut = P(1:290, 1:12);
RR = diff(P_cut) ./ P_cut(1:end-1, :);
mu = mean(RR);
sigma = cov(RR);
[T, n] = size(RR);
%% 3
H = 2 * sigma;
lb = [zeros(n, 1)];
beq = [1];
Aeq = [ones(1, n)];
X_min = quadprog(H,[],[],[],Aeq,beq,lb,[]);
eta_min = mu * X_min
eta_max = max(mu)
eta = linspace(eta_min, eta_max, 45);
%% 4
Aeq_ = [mu; ones(1, n)]
for k = 1 : length(eta)
    beq_ = [eta(k); 1]
    [X,Risk_sigma2(:, k)] = quadprog(H,[],[],[],Aeq_,beq_,lb,[]);
end
%% 5
 save('FrontieraMV.xls','Risk_sigma2')
 plot(Risk_sigma2, eta, 'b', LineWidth=2)
 xlabel('Risk-Variance')
 ylabel('Expected Return')
 title('Mean-Variance efficient frontier')
 print('G_FrontieraMV','-djpeg')
%% 6
% plotting the number of stocks against the target return eta would show
% that as the required return eta(k) grows, the number of stocks
% selected falls (down to a single stock, the one with the highest
% return)

%% 7
dev = RR - repmat(mu, T, 1)
eta_2 = linspace(eta_min, eta_max, 100)
A_1 = [dev, -eye(T),
    -dev, -eye(T)]
f_1 = [zeros(n, 1); ones(T, 1)/ T]
b_1 = [zeros(2*T, 1)]
LB_1 = [zeros(n +T, 1)]

Aeq_1 = [mu, zeros(1, T),
    ones(1, n), zeros(1, T)]
for k = 1 : length(eta_2)
    beq_1 = [eta(k); 1]
    Risk_MAD_(:, k) = linprog(f_1,A_1,b_1,Aeq_1,beq_1,LB_1,[])
end
Risk_MAD = Risk_MAD_(1:n)
figure(2)
plot(Risk_MAD, eta_2)
