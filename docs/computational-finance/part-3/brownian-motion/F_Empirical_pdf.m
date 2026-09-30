function [Emp_pdf] = F_Empirical_pdf(y, nbins)

y_min = min(y);

Y_max = max(y);

bins = linspace(y_min, Y_max, nbins);

[counts,centers] = hist(y , bins);

bar(centers, counts);

end