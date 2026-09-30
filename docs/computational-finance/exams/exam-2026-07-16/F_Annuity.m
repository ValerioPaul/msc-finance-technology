function [V_0] = F_Annuity(i,R,n)
v = 1 / (1 + i)
V_0 = R * v * ((1 - v^n) / (1 - v))
end
