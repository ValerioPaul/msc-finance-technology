clear all, clc

% Point 1

    % input of daily return matrix R
    R = [ 0.03,  0.05,  0.04,  0.02,  0.05;
          0.05,  0.06,  0.05,  0.03,  0.08;
         -0.04, -0.02,  0.01, -0.01, -0.10];

    [n, m] = size(R);                 % n (rows) are the scenarios, m (columns) are the stocks

    P_0 = [10, 20, 15, 20, 25];       % current price vector (at time 0)

    P = repmat(P_0, n, 1) .* (1 + R); % calculation of asset price simulation matrix
    % new price = current price * (1 + rate of return)
    % repmat replicates the row vector so it can be multiplied by each scenario in R

    q = [1000, 800, 1100, 700, 500];  % input of the stock share vector (number of shares held for each stock)

    V_q = P * q';                     % value of the portfolio for each scenario

    V_0 = P_0 * q';                   % current portfolio value

    R_q = (V_q / V_0) - 1;            % portfolio return for each scenario
    % (final value / initial value) - 1: one return per scenario (the three rows of R)


% Point 2 - Monte carlo simulation

    % given the previously introduced:
    %    m      number of stocks
    %    q      stock shares
    %    P_0    current price vector
    %    V_0    current portfolio value

    % Instead of three given scenarios, generate 100 random ones and see
    % how the portfolio behaves across them. The last three steps are the
    % same as in Point 1.

    n_MC = 100;                       % n_MC are the scenarios of the Monte Carlo simulation

    R_MC = randn(n_MC, m) / 10;       % simulation of a multivariate normal rv
    % 100 x 5 matrix of normal returns; dividing by 10 gives a 10% volatility

    P_MC = repmat(P_0, n_MC, 1) .* (1 + R_MC); % calculation of asset price simulation matrix

    V_MC_q = P_MC * q';               % value of the portfolio for each scenario

    R_MC_q = (V_MC_q / V_0) - 1;      % portfolio return for each scenario


% extra: histogram of the simulated returns

    figure;
    histogram(R_MC_q, 15);            % 15 bins

    title('Portfolio return distribution (Monte Carlo simulation)');
    xlabel('Portfolio return (e.g. 0.05 = 5%)');
    ylabel('Frequency (number of scenarios out of 100)');
    grid on;


% extra: 95% Value at Risk

    % "With 95% confidence, the portfolio will not lose more than X"

    % 1. confidence level
    livello_confidenza = 95;
    percentile_var = 100 - livello_confidenza; % the 5% threshold

    % 2. VaR as a return, from the percentile of the simulated returns
    VaR_95_perc = prctile(R_MC_q, percentile_var);

    % 3. print the result as a percentage
    fprintf('95%% VaR of the portfolio: %.2f%%\n', VaR_95_perc * 100);

    % 4. the same loss in currency
    VaR_95_valore = V_0 * VaR_95_perc;
    fprintf('Estimated maximum loss at 95%%: %.2f EUR\n', VaR_95_valore);
