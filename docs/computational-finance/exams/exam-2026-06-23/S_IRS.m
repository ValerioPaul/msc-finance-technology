clear all, clc

%% 1
A = readtable('Data_IRS.xlsx');
t = A{:, 1};
z = A{:, 2};
z = z / 100;
[v] = F_Bootstrap(z);
t_int = 0.5 : 0.5 : t(end);
%% 2
[v_int] = F_StructInterYield(t, v, t_int);
[forward_prices,forward_rates] = F_forward(t_int,v_int);
y_int = -log(v_int) ./ t_int
%% 3
figure(1)
hold on
plot(t_int, y_int)
plot(t_int, forward_rates)
% problem with the forward_rates chart, which does not come out right
% (not saved because wrong) print('G_StrutturaTassi','-djpeg')
