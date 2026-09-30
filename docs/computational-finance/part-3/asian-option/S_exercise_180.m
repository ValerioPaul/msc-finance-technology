clear all, clc

%% 1

n = 1e6; 
m = 100;
S_0 = 36.64; 
K = 37; 
r = 0.0175; 
T = 0.5; 
sigma = 0.2;

%% 2

Dt   = T / m;                                       
Z    = randn(n, m);                                 
dX   = (r - 0.5*sigma^2)*Dt + sigma*sqrt(Dt)*Z;    
S_tk = S_0 * exp(cumsum(dX, 2));                    

%% 3

S_bar = mean(S_tk, 2);                              

%% 4

C = exp(-r*T) * mean( max(S_bar - K, 0) )          
P = exp(-r*T) * mean( max(K - S_bar, 0) )         
