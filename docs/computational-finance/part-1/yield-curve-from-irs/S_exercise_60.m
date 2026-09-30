clear all, clc

[ndata, text, alldata] = xlsread('IRS_plain_vanilla.xlsx');

time = ndata(:, 1);
z = ndata(:, 2);   % z = swap rates
z = z / 100;      % note that it is necessary to divide z by 100, because the rates in IRS_plain_vanilla.xls are already in percentage.

% Point 1
    [v_spot] = F_es59(z);

% Point 2
    % see function F_es60.m

% Point 3
    % see function F_forward

    step = 0.5;                 % time in years (one point every six months)
    time_int = step : step : time(end);

    [v_spot_int] = F_es60(v_spot, time, time_int);

    spot_r_int = (1 ./ v_spot_int).^(1 ./ time_int) - 1;    % spot rates (converts the interpolated prices into annual rates for the plot)
    [fwd_p, fwd_r] = F_es55(v_spot_int, time_int);       % forward prices and rates from the semi-annual spot price curve

% Point 4
   % Graph
    figure(1)
    plot(time_int, spot_r_int, 'b', 'LineWidth', 2)
    hold on
    plot(time_int, fwd_r, 'r', 'LineWidth', 2)
    hold off
    xlabel('Time')
    ylabel('Rate')
    title('Spot rate and forward rate')
    legend('Spot Rates', 'Forward Rates', 'Location', 'best')

% Point 5
    % the wrong procedure on purpose: linearly interpolate the market swap
    % rates to get the semi-annual rates (instead of extracting pure rates first)
    [z_int] = interp1(time, z, time_int, 'linear', 'extrap');

    [v_spot_int] = F_es59(z_int);

    spot_r_int2 = (1 ./ v_spot_int).^(1 ./ time_int') - 1;  % spot rates

    [fwd_p, fwd_r2] = F_es55(v_spot_int', time_int);

    % Graph
    figure(2)
    plot(time_int, spot_r_int2, 'b', 'LineWidth', 2)
    hold on
    plot(time_int, fwd_r2, 'r', 'LineWidth', 2)
    hold off
    xlabel('Time')
    ylabel('Rate')
    title('Spot rate and forward rate')
    legend('Spot Rates', 'Forward Rates', 'Location', 'best')

% CONCLUSION: COMPARING THE TWO CHARTS
% The comparison shows why raw swap rates are never interpolated. The first
% chart shows smooth, realistic curves because the interpolation is applied
% to pure zero-coupon yields, extracted beforehand by bootstrapping. The
% second shows strongly unstable (zig-zag) forward rates with out-of-scale
% values: linearly interpolating swap rates introduces small coupon-related
% distortions, which forward rates (behaving like derivatives) amplify. The
% rule is to always extract pure rates before interpolating.
