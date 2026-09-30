function [Emp_cdf] = F_Empirical_cdf(x, p)

[x_sort, index_sort] = sort(x);

p_sort = p(index_sort);

Emp_cdf = cumsum(p_sort);

stairs(x_sort, Emp_cdf);

end