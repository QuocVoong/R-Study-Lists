1;

clear all;

addpath ("./common");

% Number of points
N = 100;

% Number of dimensions
d = 2;

% Number of clusters for regular RBF
K = 9;

% Gamma
gamma = 1.5;

% Input space
spc = [-1 1];

% Number of runs
runs = 100;

rundata = [];

for run = 1:runs

  % N random examples
  X = inputdata (N, d, spc);
  y = arrayfun (@ (n) target (X(n,:)), 1:N)';

  % Computes the weights using regular RBF with K centers
  do
    rbfmodel = rbf (X, y, gamma, K);
  until rbfmodel.ok;

  % Computes in-sample and out-of-sample error
  rundata(run) = errrbf (rbfmodel, X, y);
end

printf ("Average of runs with Ein=0 is %.2f\n", mean (rundata == 0));
