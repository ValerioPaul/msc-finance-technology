clear all, clc

% Point 1
    % see F_es46 (local function below)

% Point 2
    F = [5, 5, 105];                    % parameters of the problem
    i = 0.05;
    s = [1, 2, 3];
    t = [0, 1, 2, 3];

    V = F_es46(F, i, s, t)

    % output : V =  100.0000
    %               105.0000
    %               110.2500
    %               115.7625
    % value of the flow at each evaluation time t

% Point 3
    i_tilde = [0.037, 0.042, 0.051];

    V_tilde = F_es46(F, i_tilde, s, t)

% Point 4
    % save('nomefile.txt', 'V', 'V_tilde', '-ascii');


function [V_tF] = F_es46(F, i, s, t)
% INPUTS:   F := flow (cash flow amounts)
%           i := vector of interest rates (fixed or variable)
%           s := the schedule (payment dates)
%           t := times of evaluation
% OUTPUT:   cf_vector := vector of discounted cash flows
% Note that:
%   - F and s must have the same length!
%   - cf_vector and t must have the same length!
%   - i could be a scalar (flat) or a vector (floating); in the second instance
%     must have the same length of s and F

V_tF = zeros(length(t), 1);         % preallocation (one row per evaluation time)

% force F to be arow vector and S to be a column one
F = reshape(F, 1, length(F));
s = reshape(s, length(s), 1);

control = length(i);
if control ~= length(s) && control ~= 1 % only a flat curve (one rate) or a non-flat curve (one rate per date) is accepted
    disp('%%%%% The supplied yield curve is not coherent');
    return;                         % this command will abort the function
end

for k = 1:length(t)                 % for each evaluation time
    v = (1 + i)'.^(-(s - t(k)));    % discount factor vector
                                    % the exponent discounts flows after t(k) and compounds flows before it
    V_tF(k) = F * v;                % value of the cash flow evaluated at time t(k)
                                    % t(k) = 0 gives the present value; t(k) = 2 the value two years from now
end
end
