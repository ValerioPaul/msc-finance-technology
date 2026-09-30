clear all, clc

% Point 1
    % Parameters
    F = [6, 6, 6, 6, 106];
    s = [1, 2, 3, 4, 5];
    alpha = 0.0024;
    beta = 0.0097;
    gamma = 0.0033;

    % Present Value Calculation
    Present_value = F_es53(s, F, alpha, beta, gamma)
    % xlswrite('CashFlows2.xls', Present_Value_F);


function [valore_attuale_flussi] = F_es53(s, F, alpha, beta, gamma)
% inputs:   s := schedule
%           F := the flows
% output:   present_value
% s and F must have the same dimension

h_sk = alpha + beta * s + gamma * s.^2;                 % yield to maturity
i_sk = exp(h_sk) - 1;                                   % rate of interest

valore_attuale_flussi = F * ((1 + i_sk).^(-s))';        % present value of the cash flow (flows times discount factors)
end
