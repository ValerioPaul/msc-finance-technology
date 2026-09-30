function [xx, N] = F_es99(Y, nbins)

% This function computes an histogram of a PDF, given a vector of random outcomes

% inputs:   Y     = vector of random outcomes
%           nbins = number of bar for the histogram

% outputs:  xx = location of each bin
%           N  = number of elements in each bin

Ymin = min(Y); % smallest value of Y
Ymax = max(Y); % largest value of Y
               % together: the range the samples span

binc  = linspace(Ymin, Ymax, nbins); % nbins equally spaced points over [Ymin, Ymax]

[N, xx] = hist(Y, binc); % histogram with one bin centred on each point of binc

bar(xx, N); % bar creates a bar graph with one bar for each element in y

title('empirical probability density function');

end
