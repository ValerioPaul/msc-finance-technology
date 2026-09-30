clear all, clc

% Data Input

z = [0.021, 0.025, 0.032, 0.043];       % swap rates
z = z';                                 % we need a column vector


% Point 1

    % 1. square matrix where each row holds the corresponding swap rate
    M = repmat(z, 1, length(z));        % repeat z once vertically and 4 times horizontally

    % 2. keep the lower triangular part (rates on and below the diagonal)
    A = tril(M);                        % sets to zero everything above the main diagonal

    % 3. add 1 on the main diagonal only
    A = A + eye(length(z)); % eye() is the identity matrix: adding it puts a 1 on the diagonal


% Point 2
    v = A \ ones(length(z), 1)         % backslash: solves the linear system A*v = 1

    check = A * v                      % verification: should return a vector of ones
	% v are the discount factors for the 1, 2, 3 and 4 year maturities

% Point 2 alternative

	v = inv(A) * ones(4, 1)
	check = A * v
