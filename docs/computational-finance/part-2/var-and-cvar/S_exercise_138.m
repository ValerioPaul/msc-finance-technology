clear all, clc

% Point 1

    % Parameters
    n = 5;
    m = 1000;
    epsilon = 0.05;
    P0 = [7 9 24 19 15];
    q  = [20 20 10 10 10];
    V0 = q * P0';

    % Simulation
    R   = randn(m, n);
    P_T = repmat(P0, m, 1) .* exp(R);
    V_T = P_T * q';

    % P&L
    PL_T = V_T - V0;
    R_T  = log(V_T / V0);

    % Risk Measures
    PL_T_sort = sort(PL_T);
    Nepsilon  = round(epsilon * m); % round, because when epsilon*m is not an integer
                                    % the quantile index must still point to an element

    Q_PL_T  = PL_T_sort(Nepsilon);

    VaR_PL  = -Q_PL_T
    CVaR_PL = -mean(PL_T_sort(1:Nepsilon))
