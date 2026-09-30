clear all, clc

% Point 1

    fun = @(x) x(1) * x(2) * x(3)

    x01 = [2 4 8]

    A = [1 3 4; -2 -1 -1/2]

    b = [0 50]

    [x,fval] = fmincon(fun,x01,A,b,[],[],[],[])

% Point 2

    x02 = [-8 0 -3]

    [x,fval] = fmincon(fun,x02,A,b,[],[],[],[])

% fmincon (nonlinear programming) finds two different local minima from the
% two starting points, but not a global minimum (because of the shape of
% the function, which could be for example a "saddle")
