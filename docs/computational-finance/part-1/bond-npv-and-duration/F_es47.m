function [NPV, D] = F_es47(t, t_0, C, i_tilde)

% inputs:   t       := vector of the schedule
%           t_0     := (scalar) starting point of the investment
%           C       := mxn matrix of cash flows
%           i_tilde := non-flat interest rate curve
% outputs:  NPV     := Net Present Value
%           D       := Duration
% Refer to row vectors!

v = (1 + i_tilde).^(-(t - t_0));    % discount factor vector (t = payment date, t_0 = evaluation date)
NPV = C * v';                       % column vector: one net present value per asset (row of C)
D = (C * ((t - t_0) .* v)') ./ NPV;
end
