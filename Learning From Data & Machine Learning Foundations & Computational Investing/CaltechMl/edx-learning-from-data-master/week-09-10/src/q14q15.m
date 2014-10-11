1;

clear all;

addpath ("./common");

% Directory where LIBSVM .mex files are located
% addpath ("/path/to/libsvm/matlab");

% Number of points
N = 100;

% Number of dimensions
d = 2;

% Number of clusters for regular RBF. Change this according to the question
K = 9;

% Gamma
gamma = 1.5;

% Input space
spc = [-1 1];

% Number of runs
runs = 100;

run = 1;
rundata = [];

while run <= runs

  % N random examples
  X = inputdata (N, d, spc);

  % Target labels
  y = arrayfun (@ (n) target (X(n,:)), 1:N)';

  % Runs hard-margin SVM with RBF kernel
  svmmodel = svm (X, y, gamma);
  
  % Computes the weights using regular RBF with K centers
  rbfmodel = rbf (X, y, gamma, K);

  % Discards this run if we end up with empty clusters
  if (!rbfmodel.ok)
    continue;
  end

  % Generates N new random examples for testing (Eout)
  Xtest = inputdata (N, d, spc);
  ytest = arrayfun (@ (n) target (Xtest(n,:)), 1:N)';

  % Calculates Eout for each model
  eoutsvm = errsvm (svmmodel, Xtest, ytest);
  eoutrbf = errrbf (rbfmodel, Xtest, ytest);

  % Stores whether the RBF kernel outperforms regular RBF in this run
  rundata(run++) = eoutsvm < eoutrbf;
end

printf ("Average of runs where Eout[svm] > Eout[rbf] is %.2f\n", mean (rundata));
