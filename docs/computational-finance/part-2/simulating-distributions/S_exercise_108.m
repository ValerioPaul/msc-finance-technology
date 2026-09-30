clear all, clc

%% 1

n     = 10000;
mu    = 2;
sigma = 0.5;
y = mu + sigma * randn(n, 1);
x = exp(y);
x_plot = linspace(min(x), max(x), 1000);

%% 2

nbins = 100;
bin_width = (max(x) - min(x)) / nbins;
figure(1)
F_Empirical_pdf(x, nbins)
hold on
plot(x_plot, pdf('Lognormal', x_plot, mu, sigma) * n * bin_width)
hold off

%% 3

p = ones(n, 1)/n;
figure(2)
F_Empirical_cdf(x, p)
hold on
plot(x_plot, cdf('Lognormal', x_plot, mu, sigma))
hold off

%% 4

[e_x, var_x, sk_x, ku_x] = F_SynteticIndices(x)
e_x_   = exp(mu + sigma^2/2)
var_x_ = (exp(sigma^2) - 1) * exp(2*mu + sigma^2)
sk_x_  = (exp(sigma^2) + 2) * sqrt(exp(sigma^2) - 1)
ku_x_  = exp(4*sigma^2) + 2*exp(3*sigma^2) + 3*exp(2*sigma^2) - 3
