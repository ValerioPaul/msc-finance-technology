clear all, clc

% Point 1

    n = 1000000;        % number of observations to simulate
    nu = 5;        % degrees of freedom of the Student t
    mu = 0;        % mean (affine transformation parameter)
    sigma = 1;     % scale (affine transformation parameter)

% building the Student t

    Z_ = randn(n, nu+1);
    Z  = Z_(:, 1);
    Q  = sum(Z_(:, 2:end).^2, 2);
    T  = Z ./ sqrt(Q / nu);
    X  = mu + sigma * T; % affine transformation

% Point 2 - PDF

    nbins = 100;
    figure(1)
    [xx, N]          = F_es99(X, nbins);

% Point 3 - CDF

    figure(2)
    p = ones(n, 1) / n;        % equal weight 1/n for each observation
    [x_sort, F_x_emp] = F_es95(X, p);

% Point 4 - empirical vs theoretical summary statistics

    [E_x, Var_x, Skew_x, Kurt_x] = F_es100(X)

    t_E_x     = mu
    t_Var_X   = (nu / (nu-2)) * sigma^2
    t_Skew_x  = 0
    t_Kurt_x  = (6 / (nu-4)) + 3
