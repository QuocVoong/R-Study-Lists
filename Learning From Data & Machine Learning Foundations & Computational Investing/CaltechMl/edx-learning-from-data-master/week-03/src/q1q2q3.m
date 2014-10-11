1;

% Solving this by using the raw inequality agains all possible options

addpath ("./common");

% Array of sample sizes
N = 500:500:10000;

% How much Ein must deviate from Eout, at most
epsilon = 0.05;

% Probability that Ein deviates from Eout more than epsilon
delta = 0.03;

% For each power of 10 between 0 (10^0 = 1) and 2 (10^2 = 100)
for i = 0:2

  % Evaluates the hoeffding probability for all N sample sizes
  d = arrayfun (@ (n) hoeffding (n, 10^i, epsilon), N);

  % Finds the sample size that satisfies the probability restriction
  n = N(find (d <= delta)(1));

  fprintf ("Sample size for M = %d -> %d\n", m, n);
end
