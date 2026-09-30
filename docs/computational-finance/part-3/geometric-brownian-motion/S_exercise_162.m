clear all, clc

%% 1

n = 10000;
m = 200;
mu = 0.2;
sigma = 0.2;
Dt = 0.05;
S_0 = 100;

Z    = randn(n, m);
dX   = (mu - 0.5*sigma^2)*Dt + sigma*sqrt(Dt)*Z;   % increments of ln(S)
S_tk = S_0 * exp(cumsum(dX, 2));                   % S_tk = S_0 * e^{sum of the increments}

%% 2

save('GeoBM.txt', 'S_tk', '-ascii', '-tabs')

%% 3

figure(1)
plot(S_tk')
xlabel('time'); ylabel('S_t'); title('Geometric Brownian motion trajectories')

%% 4

for k = 10:20:190
    figure
    F_Empirical_pdf(S_tk(:, k), 200);
    title(['Distribution at k = ', num2str(k)])
    print('-djpeg', ['GeoBM', num2str(k)])
end
