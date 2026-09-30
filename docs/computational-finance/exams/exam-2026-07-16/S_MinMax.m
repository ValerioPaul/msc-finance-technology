clear all, clc

%
L = readtable("NASDAQ100.xlsx");
times = L{:, 1}
P = L{:, 2:end};
P_cut = P(end-289:end, 1:10);
RR = diff(P_cut) ./ P_cut(1:end-1, :); % R_cut
mu = mean(RR);
%
[T, n] = size(RR)
%
f = [zeros(n, 1); -1];
A = [-RR, ones(T, 1)];
b = zeros(T, 1);
Aeq = [ones(1, n), 0];
beq = 1;
LB = [zeros(n, 1); -inf];
[x_min, var_min] = linprog(f,A,b,Aeq,beq,LB,[]);
x_min = x_min(1:n);
eta_min = mu * x_min
eta_max = max(mu)
eta = linspace(eta_min, eta_max, 50);
%
options = optimset(MaxIter=1.e7, TolFun=1.e-10, TolX = 1.e-10)
Aeq_ = [mu, 0; ones(1, n), 0];
for k = 1 : length(eta)
    beq_ = [eta(k); 1];
    [x_port(:, k), var_port(:, k)] = linprog(f,A,b,Aeq_,beq_,LB,[], [], options); %Risk_minMax
end
%
xlswrite('FrontieraMinMax.xls','eta', 'var_port')
%
figure(1)
plot(var_port, eta, linewidth = 2)
xlabel('Risk_MinMax')
ylabel('eta')
title('Modello MinMax')
print('G_FrontieraMinMax.jpg', '-djpeg')
%
title_sort = sum(x_port > 1.e-5) % the number of stocks falls as the portfolio risk grows
figure(2)
plot(title_sort, eta)
print('G_NumAssSelected.jpg', '-djpeg')
