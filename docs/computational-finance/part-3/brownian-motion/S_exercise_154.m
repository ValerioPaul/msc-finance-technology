clear all, clc

%% 1

n     = 10000;   % number of trajectories
m     = 200;     % number of time steps
mu    = 0.1;     % drift
sigma = 0.4;     % volatility (diffusion)
Dt    = 0.1;     % time step

X = F_BrownMot(mu, sigma, m, Dt, n);   % x_0 omitted -> default 0 (nargin)

%% 2

save('BrownMot.txt', 'X', '-ascii', '-tabs')

%% Point 3

figure(1)
plot(X')
xlabel('time');
ylabel('X_t');
title('Brownian motion trajectories')

%% Point 4

for k = 10:20:190
    figure
    F_Empirical_pdf(X(:, k), 100);
    print('-djpeg',['BrownMot',num2str(k)])
end


function [X] = F_BrownMot(mu, sigma, m, Dt, n, x_0)
% Simulates n trajectories of a Brownian motion with drift mu and diffusion
% sigma, over m steps of length Dt. Formula: dX_k = mu*Dt + sigma*sqrt(Dt)*Z (5.8, p. 190)

    if nargin == 5
        x_0 = 0;                       % default initial value (textbook, p. 190)
    end

    Z  = randn(n, m);                  % N(0,1) shocks: n simulations x m steps (point 1)
    dX = mu*Dt + sigma*sqrt(Dt)*Z;     % increments (point 2)
    X = x_0 + cumsum(dX, 2);                % X_k = X_0 + sum of the increments (point 3, cumsum)

end
