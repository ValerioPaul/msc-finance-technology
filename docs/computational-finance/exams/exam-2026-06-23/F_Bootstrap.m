function [v] = F_Bootstrap(z)
n = length(z)
z = reshape(z, 1, n)
A = repmat(z, n, 1)
A = tril(A)
A = A + eye(n)
v = A \ ones(n, 1)
end
