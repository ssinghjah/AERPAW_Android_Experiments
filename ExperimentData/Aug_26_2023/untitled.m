close all;
figure;

rsrp = csvread("connected_bs_rsrp.csv");
rsrq = csvread("connected_bs_rsrq.csv");
rssi = csvread("connected_bs_rssi.csv");


[y_rssi, x_rssi] = ecdf(rssi);
[y_rsrp, x_rsrp] = ecdf(rsrp);
[y_rsrq, x_rsrq] = ecdf(rsrq);

% Create the first axes
hax1 = axes('XTick', [-120:10:-40]);


% Plot something here
xdata = 1:10;
hplot1 = line(x_rssi, y_rssi, 'Color', '#0072BD', 'DisplayName', 'CDF of RSSI (dBm)', 'LineWidth', 3);
hplot2 = line(x_rsrp, y_rsrp, 'Color', '#77AC30', 'DisplayName', 'CDF of RSRP (dBm)', 'LineWidth', 3);

set(gca, 'FontSize', 26);
    
% Create a transparent axes on top of the first one with it's xaxis on top
% and no ytick marks (or labels)
hax2 = axes('Position', get(hax1, 'Position'), ...  % Copy position
            'XAxisLocation', 'top', ...             % Put the x axis on top
            'YAxisLocation', 'right', ...           % Doesn't really matter
            'xlim', [min(x_rsrq) -7], ...                     % Set XLims to fit our data
            'xtick', [min(x_rsrq):1:-6], ...
            'Color', 'none', ...                    % Make it transparent
            'YTick', []);                           % Don't show markers on y axis
            
% Plot data with a different x-range here

hplot3 = line(x_rsrq, y_rsrq, 'Color', '#A2142F', 'Parent', hax2, 'DisplayName', 'CDF of RSRQ (dB)', 'LineWidth', 3);

% Link the y limits and position together
linkprop([hax1, hax2], {'ylim', 'Position'});

% Draw some labels
xlabel(hax1, 'RSRP / RSSI (dBm)')
xlabel(hax2, 'RSRQ (dB)')
ylabel(hax1, 'CDF')

% Add a legend? Why not?!
legend([hplot1, hplot2, hplot3], {'RSSI (dBm)', 'RSRP (dBm)', 'RSRQ (dB)'})

set(gca, 'FontSize', 26);