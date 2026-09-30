function [fwd_p, fwd_r] = F_es55(v, t)

% inputs:   v := ZCB prices
%           t := the schedule

% outputs:  fwd_p := forward prices
%           fwd_r := forward interest rates

% v and t must have the same length!

n = length(v);

% Initialization
fwd_p = zeros(1, n); % preallocation
fwd_r = zeros(1, n); % preallocation

% Calculate the first element of fwd price and rate vectors
fwd_p(1) = v(1);
fwd_r(1) = (1 / fwd_p(1))^(1 / t(1)) - 1;

for k = 2:n
    fwd_p(k) = v(k) / v(k-1);
    fwd_r(k) = (1 / fwd_p(k))^(1 / (t(k) - t(k-1))) - 1;
end

end
