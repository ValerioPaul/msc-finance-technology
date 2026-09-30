clear all, clc

% Expected return and risk (variance) of an equally weighted portfolio.

% Input data
% 1. Vector of expected returns (mu) for the 5 stocks
mu = [0.05, 0.10, 0.15, 0.08, 0.11];

% 2. 5x5 variance-covariance matrix (Sigma)
Sigma = [  0.10,   0.00,  -0.05,   0.30,  -0.70;
           0.00,   0.20,   0.15,  -0.10,   0.00;
          -0.05,   0.15,   0.50,   0.20,  -0.15;
           0.30,  -0.10,   0.20,   0.30,   0.25;
          -0.70,   0.00,  -0.15,   0.25,   0.40 ];

% number of stocks (n) from the length of mu
n = length(mu);

    % Point 1
        % equally weighted portfolio: the same share invested in each stock
        x = ones(n, 1) / n
        % portfolio weights: 20% in each of the 5 stocks

    % Point 2
        % expected return = weighted average of the stocks' expected returns
        Exp_Ret = mu * x

    % Point 3
        % portfolio variance in matrix form
        Variance = x' * Sigma * x

    % Point 4
        % save the results to a text file in the current folder
        % save('Portfolio_Exp_Return_Variance.txt', 'x', 'Exp_Ret', 'Variance', '-ascii');
