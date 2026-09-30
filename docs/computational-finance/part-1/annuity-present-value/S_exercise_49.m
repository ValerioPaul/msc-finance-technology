clear all, clc

%% 1

i = 12/100;
R = 10;
n = 17;
v = 1 / (1 + i);

V_0 = 0;

for k = 1 : n

    V_0 = V_0 + R * v^k;

end

V_0

% check
V_0_check = R * v * ((1 - v^n) / (1 - v))

%% 2

n_graph = 1:100;

V_0_graph = R * v * ((1 - v.^n_graph) / (1 - v));

asymptote = R / i

figure(1)
hold on
plot(n_graph, V_0_graph, linewidth=3)
plot(n_graph, asymptote*ones(1, 100), linewidth=3)
hold off
