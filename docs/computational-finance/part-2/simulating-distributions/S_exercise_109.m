clear all, clc

%% 1

n  = 100000;
nu = 6;
z  = randn(n, nu);
x  = sum(z.^2, 2);
x_plot = linspace(min(x), max(x), 1000);

%% 2

nbins = 300;
bin_width = (max(x) - min(x)) / nbins;
figure(1)
F_Empirical_pdf(x, nbins)
hold on
plot(x_plot, pdf('Chisquare', x_plot, nu) * n * bin_width)
hold off

%% 3

p = ones(n, 1)/n;
figure(2)
F_Empirical_cdf(x, p)
hold on
plot(x_plot, cdf('Chisquare', x_plot, nu))
hold off

%% 4
 
[e_x, var_x, sk_x, ku_x] = F_SynteticIndices(x)
e_x_   = nu
var_x_ = 2*nu
sk_x_  = sqrt(8/nu)
ku_x_  = 12/nu + 3
