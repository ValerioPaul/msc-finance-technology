clear all, clc

%% 1

x = [-100 2.5 2.5 102.5]

t = [ 0/12 6/12 12/12 18/12]

g = @(v) sum(x .* v.^(t))

v = fzero(g, 0.5)

IRR = (1 / v -1 ) * 100

% preparation for the plot

f = @(v) sum(x(2:end) .* v.^(t(2:end))) % the text says to start from k = 1, so the first flow is dropped

n = 1000

t = linspace(0.5, 0.99, n)

for k = 1 : n

    f_v(k) = f(t(k))

end

y = -x(1)

y_line = y * ones(1, n)

% plotting

figure(1)
hold on
plot(t, f_v, linewidth=3)
plot(t, y_line, linewidth=3)
hold off

% The intersection of f(v) and y is the discount factor v*
% that sets g(v) to zero, from which the IRR is obtained
