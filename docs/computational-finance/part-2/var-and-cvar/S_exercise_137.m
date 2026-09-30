clear all, clc

%% 1

n = 5;   m = 1000;

P0 = [7 9 24 19 15];        % current prices
q  = [20 20 10 10 10];      % allocation (number of shares)
V0 = q * P0';               % initial portfolio value

R   = randn(m, n);          % simulated returns (standard normal)
P_T = P0 .* exp(R);         % future prices (log-normal): P_T = P0*e^R
V_T = P_T * q';             % future portfolio values (m x 1)

PL_T = V_T - V0;            % Profit & Loss
R_T  = log(V_T / V0);       % future portfolio return

save('PortPLandRet.mat', 'PL_T', 'R_T');

%% 2

PL_sort = sort(PL_T);       % increasing order: the first ones are the worst losses
RT_sort = sort(R_T);

% epsilon = 0.05
N5 = floor(0.05 * m) + 1;
VaR_PL_5 = -PL_sort(N5)
VaR_RT_5 = -RT_sort(N5)

% epsilon = 0.01
N1 = floor(0.01 * m) + 1;
VaR_PL_1 = -PL_sort(N1)
VaR_RT_1 = -RT_sort(N1)

%% 3

nbins = 40;

figure(1)
F_Empirical_pdf(-PL_T, nbins)
hold on
xline(VaR_PL_5, '--r', 'LineWidth', 2)
xline(VaR_PL_1, '-r',  'LineWidth', 2)
xlabel('Loss (-PL)'); ylabel('Frequency'); title('Portfolio P&L distribution')
legend('pdf', 'VaR 5%', 'VaR 1%')

figure(2)
F_Empirical_pdf(-R_T, nbins)
hold on
xline(VaR_RT_5, '--r', 'LineWidth', 2)
xline(VaR_RT_1, '-r',  'LineWidth', 2)
xlabel('Loss (-R)'); ylabel('Frequency'); title('Portfolio return distribution')
legend('pdf', 'VaR 5%', 'VaR 1%')
