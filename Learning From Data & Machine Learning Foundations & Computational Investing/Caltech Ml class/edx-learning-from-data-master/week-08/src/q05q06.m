1;

clear all;

addpath ("./common");

% Directory where LIBSVM .mex files are located
% addpath ("/path/to/libsvm/matlab");

% Training data
[Xtrain ytrain] = loaddata ("../data/features.train");

% Testing data
[Xtest ytest] = loaddata ("../data/features.test");

% 1-vs-5 classifier
[Xtrain ytrain] = nvsm (1, 5, Xtrain, ytrain);
[Xtest ytest] = nvsm (1, 5, Xtest, ytest);

% Polynomial kernel
k = 1;

% Soft-margin SVM
C = 0.01;

% Polynomial kernel degree. Change this according to question
Q = 2;

% Regularization parameter
Cs = -4:0;

rundata = [];

for i = 1:length(Cs)

  % Regularization parameter for soft-margin SVM
  C = 10^Cs(i);

  % Runs SVM
  model = svm (Xtrain, ytrain, Q, C, k, 0);

  % C, Ein, Eout, nSV
  rundata(i,:) = [C err(model, Xtrain, ytrain), err(model, Xtest, ytest), sum(model.nSV)];
end

printf ("C=%.4f   Ein=%.3f   Eout=%.3f   #SVs=%d\n", rundata');
