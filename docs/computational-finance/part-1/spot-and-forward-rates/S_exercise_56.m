clear all, clc

t = [0.5, 1, 1.5, 2, 2.5];           % arbitrary schedule
v = [0.98, 0.96, 0.94, 0.925, 0.92]; % ZCB prices

% Point 1
	spot_r = (1 ./ v).^(1 ./ t) - 1    % spot interest rates

% Point 2
	[fwd_p, fwd_r] = F_es55(v, t)

% Point 3
	plot(t, spot_r, 'r', LineWidth = 2);
	hold on;
	plot(t, fwd_r, '-w', LineWidth = 2);
	hold off;
	xlabel('Time');
	ylabel('Rate');
	title('Spot and forward rates', 'FontSize', 14);
	legend({'Spot Rates', 'Forward Rates'}, 'Location', 'southwest', 'FontSize', 16);
	% print('-dtiff', 'rates_graph');     % save the plot
