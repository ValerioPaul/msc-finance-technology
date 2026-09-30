function [v] = F_bootstrap(z)

z = reshape(z, length(z), 1)
n = length(z);

A = repmat(z, 1, n);
A = tril(A);
A = A + eye(n);

v = inv(A) * ones(n, 1)

end
