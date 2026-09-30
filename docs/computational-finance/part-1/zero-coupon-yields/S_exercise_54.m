clear all, clc
format long

% Point 1
    % See F_es54 (local function below)

% Point 2
    P = [99.88, 99.85, 99.76, 99.24, 97.33];
    T = [1/4, 1/3, 1/2, 1, 2];          % 3-months, 4-months, 6-months, 1-year, 2-years to maturity

    ZCB_returns = F_es54(P, T)

% Point 3
    % save('Annual_return.txt', 'ZCB_Returns', '-ascii');


function [i] = F_es54(P, T)
% inputs:   P := price at inception
%           T := maturity
% output:   i := interest rate

n = length(P);
m = length(T);

% force the dimensions of the matrix
P = reshape(P, n, 1);   % reshape P into an n x 1 column
T = reshape(T, m, 1);   % reshape T into an m x 1 column

i = (100 ./ P).^(1 ./ T) - 1;
end
