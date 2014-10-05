1;

clear all;

addpath ("./common");

% Directory where LIBSVM .mex files are located
% addpath ("/path/to/libsvm/matlab");

% Number of points
N = 100;

% Number of dimensions
d = 2;

% Gamma
gamma = 1.5;

% Input space
spc = [-1 1];

% Number of runs
runs = 1000;

rundata = [];

for run = 1:runs

  % N random examples
  X = inputdata (N, d, spc);

  % Target labels
  y = arrayfun (@ (n) target (X(n,:)), 1:N)';

  % Runs hard-margin SVM with RBF kernel
  model = svm (X, y, gamma);

  % Stores whether the model has Ein>0
  rundata(run) = errsvm (model, X, y) > 0;
end

printf ("Average of runs where Ein>0 is %.2f\n", mean (rundata));
