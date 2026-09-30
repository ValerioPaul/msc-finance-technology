function [v_spot] = F_es59(z)

% output : v_spot := Zero Coupon Bond prices (discount factors)
% input  : z      := Swap Rate vector

z = reshape(z, length(z), 1);                        % force column vector

M = repmat(z, 1, length(z));
A = tril(M);
A = A + eye(length(z));

v_spot = A \ ones(length(z), 1);                     % solve for discount factors

end
