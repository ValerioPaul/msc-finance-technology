clear all, clc

% Point 1
	format bank

	S = 140000;
	n = 20;
	i_ = 0.057;

	% Conversion of the annual interest rate into a semi-annual interest rate.
	% This conversion is needed because the payments are semi-annual.
	i_sa = (1 + i_)^(1/2) - 1;

	% Run the functions
	Ammortamento_francese = F_es52(S, n, i_sa, 1)
	Ammortamento_italiano = F_es52(S, n, i_sa, 2)


function [Schedule] = F_es52(S, N, i_, flag)
% inputs: S    := debt amount
%         N    := number of periods
%         i_   := fixed interest rate
%         flag := control variable to select different amortization types
%                 Flag -> 1 = french; Flag => 2 = italian
%         Pay attention to the consistency between the interest rate and the payment frequency.
% output: Schedule := table of total payments, residual debt, interest share and capital share

v = 1 / (1 + i_);
time = (0:N)';

if flag == 1
    a = v * (1 - v^N) / (1 - v);        % Figured "a"
    R = S / a;                          % Constant total payment
    RR = [0; repmat(R, N, 1)];          % Total payments
    D = zeros(length(RR), 1);           % Residual debt
    I = zeros(length(RR), 1);           % Interest share
    C = zeros(length(RR), 1);           % Capital share
    D(1, 1) = S;                        % Residual debt at t=0

    for k = 2:N+1
        I(k, 1) = i_ * D(k-1, 1);
        C(k, 1) = R - I(k, 1);
        D(k, 1) = D(k-1, 1) - C(k, 1);
    end
    Schedule = [time, RR, C, I, D];

elseif flag == 2
    C = S / N;                          % Constant principal portion
    C = [0; repmat(C, N, 1)];
    D = S - cumsum(C);                  % Vector of residual debt
    I = [0; D(1:end-1, 1) * i_];        % Interest share
    R = C + I;                          % Vector of payments

    Schedule = [time, R, C, I, D];
end
end
