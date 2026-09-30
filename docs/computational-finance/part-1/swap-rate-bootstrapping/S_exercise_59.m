clear, clc

%% 1
% see the function F_bootstrap

%% 2

z = [0.0185; 0.0223; 0.0297; 0.0313];

v = F_bootstrap(z);

vv = zeros(length(z), 1);

for k = 1:length(z)
    vv(k) = (1 - z(k)*sum(vv(1:k-1))) / (1 + z(k));
end

vv

%% 3

zz = zeros(length(v), 1);

for k = 1:length(v)
    zz(k) = (1 - v(k)) / sum(v(1:k));
end

zz
