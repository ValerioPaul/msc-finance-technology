clear all, clc

% inputs from exercise 44
t = 0.5:0.5:5; % time schedule (years)

i = 0.02;
v = (1 + i).^ -t;

i_tilde = [0.008, 0.010, 0.015, 0.018, 0.025, ...
0.031, 0.037, 0.040, 0.045, 0.047];
v_tilde = (1 + i_tilde).^ -t;


% Point 1
    load('Exercise_17.mat');

    % Present Value with flat yield curve
    PV_flat = C * v'

    % Present Value with non-flat yield curve
    PV_nonflat = C * v_tilde'

% Point 2
    % Duration of the five assets with a flat yield curve
    D_flat = (C * (t .* v)') ./ (C * v')            % numerator: present values weighted by time
                                                    % denominator: present value of all the cash flows

    % Duration of the five assets with a non-flat yield curve
    D_nonflat = (C * (t .* v_tilde)') ./ (C * v_tilde')

% Point 3
    q = [50, 100, 70, 80, 30];

    % Duration of portfolio q with a flat yield curve
    D_portq_flat = (q * C * (t .* v)') ./ (q * C * v')

    % Duration of portfolio q with a non-flat yield curve
    D_portq_nonflat = (q * C * (t .* v_tilde)') ./ (q * C * v_tilde')
