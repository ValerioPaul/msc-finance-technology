clear all, clc

%% 1

n = 100000;
nbins = 50;

Z = randn(n, 1);
p = ones(n, 1) / n;

%% 2

figure(1)
F_Empirical_pdf(Z, nbins);
print('-djpeg','G_MCmethodIn_pdf')

figure(2)
F_Empirical_cdf(Z, p);
print('-djpeg','G_MCmethodIn_cdf')

%% 3

Y = F_MCmethod(Z);

%% 4

[E_Y, Var_Y, Skew_Y, Kurt_Y] = F_SynteticIndices(Y)

figure(3)
F_Empirical_pdf(Y, nbins);
print('-dtiff','G_MCmethodOut_pdf')

figure(4)
F_Empirical_cdf(Y, p);
print('-dtiff','G_MCmethodOut_cdf')

%% 5

% The output Y is distributed as a Uniform(0,1), not as the normal Z it
% started from. The charts show it: the empirical pdf is flat on [0,1] and
% the cdf grows linearly from (0,0) to (1,1). The summary statistics agree,
% matching those of a uniform (Section 2.6): mean ~ 0.5, variance ~ 0.083,
% skewness ~ 0 and kurtosis ~ 1.8. The reason is that the function phi used
% as a black box is the CDF of the standard normal: applied to samples of Z,
% which are exactly normal, it turns them into a Uniform(0,1).
