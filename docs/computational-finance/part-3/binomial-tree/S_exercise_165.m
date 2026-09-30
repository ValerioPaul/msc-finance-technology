clear all, clc

%% 1

% Inputs of the problem

T = 1;          % time to maturity
K = 100;        % strike price
S_0 = 100;      % current price
i = 0.05;       % risk free rate
sigma = 0.20;   % volatility of the underlying
N = 50;         % number of time steps
[C,P,pcp] = F_es165(T,K,S_0,i,sigma,N)





function [Call_price,Put_price,PutcallParity]=F_es165(T,K,S_0,i,sigma,N)

% EXERCISE PRICE OF A EUROPEAN OPTION

% INPUTS:   T     := maturity;
%           K     := strike price;
%           S_0   := current price;
%           i     := risk free rate;
%           sigma := volatility of the underlying;
%           N     := steps;

% OUTPUTS:  Call_price := price of the European Call
%           Put_price  := price of the European Put
%           PutcallParity := check with the Put-Call Parity formula

% CRR parametrization
delta_t = T/N;                % length of a single step
r=log(1+i);                   % continuously compounded interest rate
u = exp(sigma*sqrt(delta_t)); % upstate coefficient  
d = 1/u;                      % downstate coefficient
q = (exp(r*delta_t)-d)/(u-d); % risk neutral probability related to the upstate
NodesCall = NaN(N+1,N+1);     % initialize the matrix,
                              % containing the nodes of the recombining binomial tree
NodesPut = NaN(N+1,N+1); 
% payoff at maturity T (i.e., j=N)
for k = 0:N
    NodesCall(k+1,N+1) = max(0,S_0*(u^k)*(d^(N-k))-K);
    NodesPut(k+1,N+1)  = max(0,K-S_0*(u^k)*(d^(N-k)));
end
% Apply a backward procedure to find the value of the option
for j = N-1:-1:0
    for k = 0:j
        NodesCall(k+1,j+1) = exp(-r*delta_t)*(q*NodesCall(k+2,j+2) + (1-q) *NodesCall(k+1,j+2));
        NodesPut(k+1,j+1)  = exp(-r*delta_t)*(q*NodesPut(k+2,j+2)  + (1-q) *NodesPut(k+1,j+2));
    end
end
Call_price = NodesCall(1,1);  % the price of a call in t=0
Put_price  = NodesPut(1,1);   % the price of a put in t=0
% check the price of the put using the put-call-parity relationship
PutcallParity = Call_price-S_0+K*exp(-r*T);
end
