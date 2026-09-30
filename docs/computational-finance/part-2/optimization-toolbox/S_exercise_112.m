clear all, clc

% Point 1

   f = [ -5 -4 -6];

   A = [ 1 -1 1;
         3 2 4;
         3 2 0];

   b = [ 20; 42; 30];

   Aeq = [];
   beq = [];

   lb = zeros(length(f), 1);
   ub = [];

   [x, fval] = linprog(f,A,b,Aeq,beq,lb,ub)
