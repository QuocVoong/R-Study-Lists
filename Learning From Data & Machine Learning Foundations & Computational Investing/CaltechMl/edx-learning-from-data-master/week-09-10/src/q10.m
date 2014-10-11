1;

clear all;

addpath ("./common");

% Regularization parameter
lambdas = [0.01 1];

% Loads the training data
[X y] = loaddata ("../data/features.train");
X = transform (X);

% Loads the testing data
[Xtest ytest] = loaddata ("../data/features.test");
Xtest = transform (Xtest);

% 1-vs-5 classifier
[X ny] = nvsm (1, 5, X, y);
[Xtest nytest] = nvsm (1, 5, Xtest, ytest);

rundata = [];

for i = 1:length(lambdas)

  lambda = lambdas(i);

  % Runs linear regression with regularization
  w = linearreg (X, ny, lambda);

  rundata(i,:) = [lambda binerr(w, X, ny) binerr(w, Xtest, nytest)];
end

% Format: lambda, Ein, Eout
rundata
