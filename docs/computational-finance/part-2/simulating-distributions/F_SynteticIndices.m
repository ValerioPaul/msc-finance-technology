function[E_x, Var_x, Sk_x, Ku_x] = F_SynteticIndices(x)

E_x = mean(x)

Var_x = mean((x - mean(x)).^2)

Dev_x = sqrt(Var_x);
 
Sk_x = mean(((x - mean(x)) ./ Dev_x).^3)   

Ku_x = mean(((x - mean(x)) ./ Dev_x).^4)

end
