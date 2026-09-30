clear all, clc

i = 0.10
R = 15
n = 20
v = 1 / (1 + i)
V_0 = R * v * ((1 - v^n) / (1 - v))
%
V_0_funct = F_Annuity(i,R,n)
%
V_0_for = R*v(1);
for k = 2 : n
    V_0_for = V_0_for +  R * v^k;
end
V_0_for
%
n_graph = 1:100;
asympt = R / i
T = R * v * (1 - v.^n_graph) / (1 - v)
figure(1)
hold on
plot(n_graph, T)
plot(n_graph, asympt*ones(1, 100))
 print('G_Annuity.jpg', '-djpeg')
