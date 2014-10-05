1;

clear all;

addpath ("./common");

% Regularization parameter
lambda = 1;

% Choices of labels for the n-vs-all classifier
Ns = 5:9;

% Loads the training data
[X y] = loaddata ("../data/features.train");

% Adds x0 coordinate
X = [ones(length (X), 1) X];

rundata = [];

for i = 1:length(Ns)

  n = Ns(i);

  % n-vs-all classifier
  ny = nvsall (n, y);

  % Runs linear regression with regularization
  wlin = linearreg (X, ny, lambda);

  rundata(i) = binerr (wlin, X, ny);
end

besterr = min (rundata);
bestn = Ns(find (rundata == besterr));

printf ("%d-vs-all gave the best ein of %.3f\n", bestn, besterr)
