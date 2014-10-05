1;

clear all;

addpath ("./common");

% Regularization parameter
lambda = 1;

% Choices of labels for the n-vs-all classifier
Ns = 0:4;

% Loads the training data
[X y] = loaddata ("../data/features.train");
X = transform (X);

% Loads the testing data
[Xtest ytest] = loaddata ("../data/features.test");
Xtest = transform (Xtest);

rundata = [];

for i = 1:length(Ns)

  n = Ns(i);

  % n-vs-all classifier
  ny = nvsall (n, y);
  nytest = nvsall (n, ytest);

  % Runs linear regression with regularization
  wlin = linearreg (X, ny, lambda);

  % Calculates classification data on the test set (Eout)
  rundata(i) = binerr (wlin, Xtest, nytest);
end

besterr = min (rundata);
bestn = Ns(find (rundata == besterr));

printf ("%d-vs-all gave the best eout of %.3f\n", bestn, besterr);
