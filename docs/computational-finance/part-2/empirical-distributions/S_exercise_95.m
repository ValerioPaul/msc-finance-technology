clear all, clc

% detailed explanation in F_es95

% Point 1
    x = [ 2 4 1 5];
    p = [ 1/4 1/16 1/2 3/16];
    % check that the probabilities sum to 1: sum(p)

    [x_sort, Emp_cdf] = F_es95(x, p)
