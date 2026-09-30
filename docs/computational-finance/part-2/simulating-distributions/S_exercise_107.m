clear all, clc

%% 1

n     = 100000;
mu    = 1;
sigma = 2;
x     = mu + sigma * randn(n, 1);
x_plot = linspace(min(x), max(x), 1000);

%% 2

nbins = 300;
bin_width = (max(x) - min(x)) / nbins;
figure(1)
F_Empirical_pdf(x, nbins)
hold on
plot(x_plot, pdf('Normal', x_plot, mu, sigma) * n * bin_width)
hold off

%% 3

p = ones(n, 1)/n;
figure(2)
F_Empirical_cdf(x, p)
hold on
plot(x_plot, cdf('Normal', x_plot, mu, sigma))
hold off

%% 4

[e_x, var_x, sk_x, ku_x] = F_SynteticIndices(x)
e_x_   = mu
var_x_ = sigma^2
sk_x_  = 0
ku_x_  = 3
