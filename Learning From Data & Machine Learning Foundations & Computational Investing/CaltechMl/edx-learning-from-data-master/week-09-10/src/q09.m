1;

clear all;

addpath ("./common");

% Regularization parameter
lambda = 1;

% Choices of labels for the n-vs-all classifier
Ns = 0:9;

% Loads the training data
[X y] = loaddata ("../data/features.train");
Xt = transform (X);

% Loads the testing data
[Xtest ytest] = loaddata ("../data/features.test");
Xttest = transform (Xtest);

rundata = [];

for i = 1:length(Ns)

  n = Ns(i);

  % n-vs-all classifier
  ny = nvsall (n, y);
  nytest = nvsall (n, ytest);

  % Runs linear regression on the original training example
  w = linearreg (X, ny, lambda);

  % Runs linear regression on the transformed training example
  wt = linearreg (Xt, ny, lambda);

  rundata(i,:) = [n ...
                  binerr(w, X, ny)   binerr(w, Xtest, nytest) ...
                  binerr(wt, Xt, ny) binerr(wt, Xttest, nytest)];
end

% Format: N-vs-all, Ein (orig), Eout (orig), Ein (trans), Eout (trans)
rundata
