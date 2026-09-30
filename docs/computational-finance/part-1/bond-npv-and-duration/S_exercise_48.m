clear all, clc

% Point 1
    t_0 = 0;                    % by default
    t = 1:5;                    % schedule

    C = [7 7 7 7 107;           % flows matrix
         6 6 6 106 0;
         0 0 100 0 0;
         0 0 0 0 100];

    i_tilde = [.05, .046, .044, .049, .052]; % non-flat yield structure

    [NPV,D] = F_es47(t,t_0,C,i_tilde)
