1;

clear all;

addpath ("./common");

% Directory where LIBSVM .mex files are located
% addpath ("/path/to/libsvm/matlab");

% Training data
[X y] = loaddata ("../data/features.train");

% 1-vs-5 classifier
[X y] = nvsm (1, 5, X, y);

% Polynomial kernel
kt = 1;

% Polynomial kernel degree
Q = 2;

% Soft-margin SVM
C = 0.01;

% Regularization parameter
Cs = -4:0;

% 10-fold cross-validation
k = 10;

% Number of runs to average cross-validation results over
runs = 100;

rundata = [];

for i = 1:runs
  for j = 1:length(Cs)

    % Shuffles the training examples
    r = randperm (size (X, 1));
    X = X(r,:); y = y(r,:);

    % Regularization parameter for soft-margin SVM
    C = 10^Cs(j);

    % Runs SVM and computes the k-fold cross-validation
    Ecv = svm (X, y, Q, C, kt, k);

    rundata(i,j) = Ecv;
  end
end

% Finds the index of Cs with smallest Ecv
m = min (rundata, [], 2);
best = arrayfun (@ (n) min (find (rundata(n,:) == m(n))), 1:runs);

bestC = 10^Cs(mode (best));
bestEcv = mean (arrayfun (@ (n) rundata(n,best(n)), 1:runs));

printf ("C=%.4f was selected most often based on Ecv\n", bestC);
printf ("Expected Ecv of the winning selection is %.4f\n", bestEcv);
