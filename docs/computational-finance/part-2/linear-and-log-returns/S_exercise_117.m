clear all, clc

%% 1

P = [10 10.3 10.7 12 14.2 14.9 19 10.4 16 8.5]

R_lin = diff(P) ./ P(1 : end-1)

R_log = diff(log(P))

%% 2

t = length(P);

R_lin_ = NaN(1, t-1);

for k = 2 : t;
    R_lin_(k-1) = (P(k) - P(k-1)) ./ (P(k-1));
end

R_lin_

R_log_ = NaN(1, t-1);

for k = 2 : t;
    R_log_(k-1) = log(P(k) ./ P(k-1));
end

R_log_
