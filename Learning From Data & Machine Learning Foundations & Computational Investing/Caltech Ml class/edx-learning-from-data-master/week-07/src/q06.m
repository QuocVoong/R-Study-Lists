1;

clear all;

% Number of points
N = 1000000;

% Number of variables
d = 2;

% Generates N random variables between 0 and 1
X = rand (N, d);

% Adds the third variable
X(:, d+1) = arrayfun (@ (n) min (X(n, :)), 1:length (X));

% Calculates the estimates
fprintf ("Expected value of x1 is %.2f\n", mean (X(:, 1)));
fprintf ("Expected value of x2 is %.2f\n", mean (X(:, 2)));
fprintf ("Expected value of x3 is %.2f\n", mean (X(:, 3)));
