function [v_int] = F_StructInterYield(t, v, t_int)
y = -log(v) ./ t
y_int = interp1(t, y, t_int)
v_int = exp(-y_int .* t_int)
end
