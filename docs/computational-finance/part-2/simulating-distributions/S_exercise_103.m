clear all, clc

%% 1

n = 100000;
a = 2;
b = 7;
x = a + (b - a) * rand(n, 1);
x_plot = linspace(a, b, 1000);   % grid for the theoretical curves

%% 2

nbins = 300;
figure(1)
F_Empirical_pdf(x, nbins)
hold on
plot(x_plot, pdf('Uniform', x_plot, a, b))

%% 3

p = ones(n, 1)/n;
figure(2)
hold on
F_Empirical_cdf(x, p)
plot(x_plot, cdf('Uniform', x_plot, a, b))

%% 4

[E_x, Var_x, Sk_x, Ku_x] = F_SynteticIndices(x)
E_x_   = a + (b - a)/2
Var_x_ = (b - a)^2 / 12
Sk_x_  = 0
Ku_x_  = 9/5
