clear all; close all; clc;

% The exercise uses the file DowJones_price.xlsx. Since the stocks named in
% exercise 119 are not in it, four others are chosen: AAPL, JPM, CVX, JNJ.


% Point 1 — Import and returns

    T = readtable("DowJones_price.xlsx");

    % --- Prices ---
    % T{:, 'col'} extracts the column as a plain numeric vector, without labels.
    % Curly braces are what let us work with vectors and matrices.
    AAPL_prices = T{:, 'AAPL_OQ'};
    JPM_prices  = T{:, 'JPM_N'};
    CVX_prices  = T{:, 'CVX_N'};
    JNJ_prices  = T{:, 'JNJ_N'};

    % --- Linear returns ---
    % Technical note: in exercise 117 we had a row vector; here we have column
    % vectors. diff recognises the shape and works in both cases.
    AAPL_returns = diff(AAPL_prices) ./ AAPL_prices(1:end-1);
    JPM_returns  = diff(JPM_prices)  ./ JPM_prices(1:end-1);
    CVX_returns  = diff(CVX_prices)  ./ CVX_prices(1:end-1);
    JNJ_returns  = diff(JNJ_prices)  ./ JNJ_prices(1:end-1);

    % --- Full returns matrix, saved to file ---
    Returns = [AAPL_returns, JPM_returns, CVX_returns, JNJ_returns];
    writematrix(Returns, 'DowJones_returns.xlsx');



% Point 2 — Plot of the returns

    figure(1)
    plot(AAPL_returns);
    title('AAPL - Apple');      ylabel('Linear Returns'); xlabel('Days');

    figure(2)
    plot(JPM_returns);
    title('JPM - JP Morgan');   ylabel('Linear Returns'); xlabel('Days');

    figure(3)
    plot(CVX_returns);
    title('CVX - Chevron');     ylabel('Linear Returns'); xlabel('Days');

    figure(4)
    plot(JNJ_returns);
    title('JNJ - J&J');         ylabel('Linear Returns'); xlabel('Days');



% Point 3 — Descriptive statistics

    % mean(X, 1): works along dimension 1 (rows): collapses all the rows into
    % one value, column by column -> one statistic per asset.
    % With 2 it would work by row.
    Exp_returns = mean(Returns, 1);
    Std         = std(Returns,  1);
    Skew        = skewness(Returns, 1);
    Kurt        = kurtosis(Returns, 1);
    Sigma       = cov(Returns);

    % save 'DowJones_Workspace.mat'   % uncomment to save the workspace



% Point 4 — Stationarity analysis


    % Stationarity requires the probability distribution not to change over
    % time. To check it empirically, the history is split into two
    % sub-periods and their distributions and summary statistics are compared.
    % Split: Period 1 = 2006-2015 (2513 obs) | Period 2 = 2016-2026 (2576 obs)


    split   = 2513;
    split_r = split - 1;    % there is one return fewer than prices

    % --- Split prices ---
    AAPL_p1 = AAPL_prices(1:split);        AAPL_p2 = AAPL_prices(split+1:end);
    JPM_p1  = JPM_prices(1:split);         JPM_p2  = JPM_prices(split+1:end);
    CVX_p1  = CVX_prices(1:split);         CVX_p2  = CVX_prices(split+1:end);
    JNJ_p1  = JNJ_prices(1:split);         JNJ_p2  = JNJ_prices(split+1:end);

    % --- Split returns ---
    AAPL_r1 = AAPL_returns(1:split_r);     AAPL_r2 = AAPL_returns(split_r+1:end);
    JPM_r1  = JPM_returns(1:split_r);      JPM_r2  = JPM_returns(split_r+1:end);
    CVX_r1  = CVX_returns(1:split_r);      CVX_r2  = CVX_returns(split_r+1:end);
    JNJ_r1  = JNJ_returns(1:split_r);      JNJ_r2  = JNJ_returns(split_r+1:end);



% 4.1 PDF of the prices

    nbins_p = 50;

    figure(5)
    subplot(1,2,1); F_es99(AAPL_p1, nbins_p); title('AAPL - Prices PDF 2006-2015'); xlabel('Price'); ylabel('Frequency');
    subplot(1,2,2); F_es99(AAPL_p2, nbins_p); title('AAPL - Prices PDF 2016-2026'); xlabel('Price'); ylabel('Frequency');
    sgtitle('AAPL - Price Distribution', 'FontSize', 14, 'FontWeight', 'bold');

    figure(6)
    subplot(1,2,1); F_es99(JPM_p1, nbins_p); title('JPM - Prices PDF 2006-2015'); xlabel('Price'); ylabel('Frequency');
    subplot(1,2,2); F_es99(JPM_p2, nbins_p); title('JPM - Prices PDF 2016-2026'); xlabel('Price'); ylabel('Frequency');
    sgtitle('JPM - Price Distribution', 'FontSize', 14, 'FontWeight', 'bold');

    figure(7)
    subplot(1,2,1); F_es99(CVX_p1, nbins_p); title('CVX - Prices PDF 2006-2015'); xlabel('Price'); ylabel('Frequency');
    subplot(1,2,2); F_es99(CVX_p2, nbins_p); title('CVX - Prices PDF 2016-2026'); xlabel('Price'); ylabel('Frequency');
    sgtitle('CVX - Price Distribution', 'FontSize', 14, 'FontWeight', 'bold');

    figure(8)
    subplot(1,2,1); F_es99(JNJ_p1, nbins_p); title('JNJ - Prices PDF 2006-2015'); xlabel('Price'); ylabel('Frequency');
    subplot(1,2,2); F_es99(JNJ_p2, nbins_p); title('JNJ - Prices PDF 2016-2026'); xlabel('Price'); ylabel('Frequency');
    sgtitle('JNJ - Price Distribution', 'FontSize', 14, 'FontWeight', 'bold');

    % Results - PDF of the prices:
    % The visual evidence of non-stationarity is striking: in all 4 cases the
    % distributions cover completely different price ranges, with almost no
    % overlap.
    %
    % AAPL: the most extreme case. In 2006-2015 prices between $2 and $30; in
    %       2016-2026 between $40 and $280. The distribution moves by an order
    %       of magnitude.
    % JPM:  from bell-shaped ($20-$65) in P1 to bimodal ($50-$330) in P2.
    %       The two peaks of P2 reflect the pre- and post-Covid-19 phases.
    % CVX:  flat and wide distribution in P1 ($55-$135), typical of an energy
    %       stock. In P2 two separate clusters (2020 crash + recovery).
    % JNJ:  moves from $50-110 to $100-250, keeping a more regular shape —
    %       consistent with the defensive nature of the healthcare sector.



% 4.2 Summary statistics of the prices

    % Period 1
    [E_AAPL_p1, Var_AAPL_p1, Skew_AAPL_p1, Kurt_AAPL_p1] = F_es100(AAPL_p1);
    [E_JPM_p1,  Var_JPM_p1,  Skew_JPM_p1,  Kurt_JPM_p1]  = F_es100(JPM_p1);
    [E_CVX_p1,  Var_CVX_p1,  Skew_CVX_p1,  Kurt_CVX_p1]  = F_es100(CVX_p1);
    [E_JNJ_p1,  Var_JNJ_p1,  Skew_JNJ_p1,  Kurt_JNJ_p1]  = F_es100(JNJ_p1);

    % Period 2
    [E_AAPL_p2, Var_AAPL_p2, Skew_AAPL_p2, Kurt_AAPL_p2] = F_es100(AAPL_p2);
    [E_JPM_p2,  Var_JPM_p2,  Skew_JPM_p2,  Kurt_JPM_p2]  = F_es100(JPM_p2);
    [E_CVX_p2,  Var_CVX_p2,  Skew_CVX_p2,  Kurt_CVX_p2]  = F_es100(CVX_p2);
    [E_JNJ_p2,  Var_JNJ_p2,  Skew_JNJ_p2,  Kurt_JNJ_p2]  = F_es100(JNJ_p2);

    %              MEAN        VARIANCE     SKEWNESS    KURTOSIS
    % AAPL  P1:    13.04         81.14        0.57        2.12
    % AAPL  P2:   119.98       5675.50        0.29        1.80
    % JPM   P1:    45.99         96.93        0.29        2.81
    % JPM   P2:   143.99       4215.60        1.19        3.67
    % CVX   P1:    92.45        405.86        0.06        1.84
    % CVX   P2:   127.98        794.41        0.18        2.17
    % JNJ   P1:    72.81        254.63        0.95        2.37
    % JNJ   P2:   150.13        590.96        0.85        5.13
    %
    % Comment:
    % MEAN:     changes drastically for every stock. AAPL: from $13 to $120
    %           (+820%). A stationary process would have a stable mean.
    % VARIANCE: explodes in P2. AAPL: from 81 to 5676 (x70). Higher prices
    %           mean larger absolute swings.
    % SKEWNESS: changes sign or intensity — the shape of the distribution is
    %           not constant. JPM goes from 0.29 to 1.19 in the second period.
    % KURTOSIS: all values < 3 — prices have lighter tails than a Gaussian,
    %           the opposite of returns (see below).



% 4.3 PDF of the returns

    nbins_r = 100;

    figure(9)
    subplot(1,2,1); F_es99(AAPL_r1, nbins_r); title('AAPL - Returns PDF 2006-2015'); xlabel('Return'); ylabel('Frequency');
    subplot(1,2,2); F_es99(AAPL_r2, nbins_r); title('AAPL - Returns PDF 2016-2026'); xlabel('Return'); ylabel('Frequency');
    sgtitle('AAPL - Returns Distribution', 'FontSize', 14, 'FontWeight', 'bold');

    figure(10)
    subplot(1,2,1); F_es99(JPM_r1, nbins_r); title('JPM - Returns PDF 2006-2015'); xlabel('Return'); ylabel('Frequency');
    subplot(1,2,2); F_es99(JPM_r2, nbins_r); title('JPM - Returns PDF 2016-2026'); xlabel('Return'); ylabel('Frequency');
    sgtitle('JPM - Returns Distribution', 'FontSize', 14, 'FontWeight', 'bold');

    figure(11)
    subplot(1,2,1); F_es99(CVX_r1, nbins_r); title('CVX - Returns PDF 2006-2015'); xlabel('Return'); ylabel('Frequency');
    subplot(1,2,2); F_es99(CVX_r2, nbins_r); title('CVX - Returns PDF 2016-2026'); xlabel('Return'); ylabel('Frequency');
    sgtitle('CVX - Returns Distribution', 'FontSize', 14, 'FontWeight', 'bold');

    figure(12)
    subplot(1,2,1); F_es99(JNJ_r1, nbins_r); title('JNJ - Returns PDF 2006-2015'); xlabel('Return'); ylabel('Frequency');
    subplot(1,2,2); F_es99(JNJ_r2, nbins_r); title('JNJ - Returns PDF 2016-2026'); xlabel('Return'); ylabel('Frequency');
    sgtitle('JNJ - Returns Distribution', 'FontSize', 14, 'FontWeight', 'bold');

    % Results - PDF of the returns:
    % The contrast with prices is immediate: the distributions of the two
    % periods almost overlap for all 4 stocks. Same bell shape, same centre
    % around zero, same order of magnitude in the tails.
    %
    % AAPL: centred on zero, tails between -0.15 and +0.15.
    %       The shape is practically identical in the two periods.
    % JPM:  similar in the two periods. P1 shows slightly heavier tails
    %       because of the 2008 financial crisis.
    % CVX:  almost identical in shape and width, tails between -0.20 and +0.20.
    % JNJ:  the most stable stock — much narrower tails (+-0.08), the two
    %       distributions overlap almost perfectly.



% 4.4 Summary statistics of the returns

    % Period 1
    [E_AAPL_r1, Var_AAPL_r1, Skew_AAPL_r1, Kurt_AAPL_r1] = F_es100(AAPL_r1);
    [E_JPM_r1,  Var_JPM_r1,  Skew_JPM_r1,  Kurt_JPM_r1]  = F_es100(JPM_r1);
    [E_CVX_r1,  Var_CVX_r1,  Skew_CVX_r1,  Kurt_CVX_r1]  = F_es100(CVX_r1);
    [E_JNJ_r1,  Var_JNJ_r1,  Skew_JNJ_r1,  Kurt_JNJ_r1]  = F_es100(JNJ_r1);

    % Period 2
    [E_AAPL_r2, Var_AAPL_r2, Skew_AAPL_r2, Kurt_AAPL_r2] = F_es100(AAPL_r2);
    [E_JPM_r2,  Var_JPM_r2,  Skew_JPM_r2,  Kurt_JPM_r2]  = F_es100(JPM_r2);
    [E_CVX_r2,  Var_CVX_r2,  Skew_CVX_r2,  Kurt_CVX_r2]  = F_es100(CVX_r2);
    [E_JNJ_r2,  Var_JNJ_r2,  Skew_JNJ_r2,  Kurt_JNJ_r2]  = F_es100(JNJ_r2);

    %              MEAN (x1e-4)   VARIANCE (x1e-4)  SKEWNESS   KURTOSIS
    % AAPL  P1:      10.11            4.62            -0.07       8.33
    % AAPL  P2:       9.74            3.33             0.15       9.86
    % JPM   P1:       5.77            7.68             1.00      18.82
    % JPM   P2:       7.33            3.02             0.32      16.46
    % CVX   P1:       3.19            3.05             0.54      18.53
    % CVX   P2:       4.77            3.41            -0.31      27.03
    % JNJ   P1:       2.56            1.06             0.68      16.85
    % JNJ   P2:       4.03            1.34            -0.22      12.45
    %
    % Comment:
    % MEAN:     same order of magnitude in the two periods — no systematic
    %           drift. AAPL stays around 0.001 in both periods.
    % VARIANCE: same order of magnitude (1e-4) in both periods.
    %           JPM falls from 7.68 to 3.02: lower volatility after the 2008 crisis.
    % SKEWNESS: small values of varying sign — no systematic asymmetry.
    %           It changes sign between the periods for AAPL, CVX and JNJ.
    % KURTOSIS: all values >> 3 in both periods — persistent fat tails.
    %           Extreme events happen far more often than a Gaussian
    %           predicts. A property that is stable over time.
    %
    % Overall conclusion:
    % Prices are NOT stationary: mean, variance and shape change drastically
    % between the two periods for every stock.
    % Returns ARE (approximately) stationary: their distribution stays stable
    % over time. This is the fundamental reason why finance always works with
    % returns and not with prices.
