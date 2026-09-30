clear all, clc

% Point 1
    n = 1000000;
    x = randn(n, 1);

    [E_x, Var_x, Skew_x, Kurt_x] = F_es100(x)


function [E_x, Var_x, Skew_x, Kurt_x] = F_es100(x)

% Function computing several summary statistics

% Expected value
E_x   = mean(x);        % arithmetic mean
x_    = x - (E_x);      % deviations: how far each observation is from the mean

% Variance
Var_x = mean((x_).^2);  % the variance is the mean of the squared deviations
dev_x = sqrt(Var_x);    % standard deviation (square root of the variance)

% Skewness
Skew_x = mean((x_ ./ dev_x).^3); % deviations divided by the standard deviation (standardisation)
                                 % make the measure unit-free; then cube and average.

% Kurtosis
Kurt_x = mean((x_ ./ dev_x).^4); % same logic as the skewness, with the fourth power (always positive).
                                 % It measures how peaked the distribution is and how heavy its tails are.
                                 % A normal distribution has kurtosis = 3; higher values mean a sharper
                                 % peak and fat tails, lower values a flatter distribution.

end

% alternatively, MATLAB's built-in functions:
% kurtosis(x)
% skewness (x)
% var(x)
