function [x_sort, Emp_cdf] = F_es95(x, p)

% The CDF (Cumulative Distribution Function) must be computed in increasing
% order of x: otherwise cumsum would add up the probabilities in the wrong
% order and the result would be meaningless.

% inputs:    x := random vector (values of the random variable)
%            p := probabilities linked to each element of x
% outputs:   x_sort := vector of the sorted random variables x
%            Emp_cdf := vector of the cumulative probabilities associated with x_sort

[x_sort, Ind_sort] = sort(x);   % example: x = [5, 2, 8]
                                % x_sort    = [2, 5, 8]
                                % Ind_sort  = [2, 1, 3]   (original position of each element)

p_sort = p(Ind_sort);           % reorder the probabilities to follow x_sort (otherwise they would be attached to the wrong values)

Emp_cdf = cumsum(p_sort);       % cumulative sum of the probabilities

stairs(x_sort, Emp_cdf, 'LineWidth', 2)   % plotting the CDF (stairs, because an empirical CDF is piecewise constant)
title('Empirical Cumulative Distribution Function')
xlabel('x')
ylabel('F_X(x)')
% figure

end
