clear all, clc

% Point 1
    n = 100000;
    y = randn(n, 1);
    nbins = 4000;
    [xx, N] = F_es99(y, nbins);


function [xx, N] = F_es99(Y, nbins)

% This function computes an histogram of a pdf, given a vector of random outcomes

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

%
% Goal: answer the question "given a set of random values, how often do
% certain values occur?". The answer is the empirical distribution, shown
% as a histogram.
%
% THE LOGIC IN THREE STEPS:
%
% 1) FIND THE BOUNDARIES
%    min(Y) and max(Y) give the interval that contains all the data.
%    A space cannot be split into equal parts before knowing how big it is.
%
% 2) SPLIT THE SPACE INTO EQUAL PARTS
%    linspace creates 'nbins' equally spaced centres between Ymin and Ymax.
%    Each centre defines a "bin" that collects the values of Y close to it.
%    More bins = more resolution; fewer bins = a coarser view.
%
% 3) COUNT AND DRAW
%    hist assigns each value of Y to the nearest bin and counts them.
%    bar turns the counts into a bar chart:
%    tall bars = frequent values, short bars = rare values.
%
% NOTE: the chart shows the *empirical* distribution, the one actually
% observed in the data, not the theoretical one. With many samples in Y
% the two converge (law of large numbers).
