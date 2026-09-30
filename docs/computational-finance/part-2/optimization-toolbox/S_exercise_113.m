clear all, clc

%% 1

H = [2 -1; -1 2] % squared terms: coefficient times 2;
                 % cross term: as it is, placed symmetrically

f = [-2 -6] % coefficients of the linear part

A = [1 1;
     -1 2;
     2 1] % coefficients of the inequality constraints

b = [2; 2; 3] % right-hand side of the inequality constraints

lb = zeros(2, 1)

[x,fval] = quadprog(H,f,A,b,[],[],lb,[])
