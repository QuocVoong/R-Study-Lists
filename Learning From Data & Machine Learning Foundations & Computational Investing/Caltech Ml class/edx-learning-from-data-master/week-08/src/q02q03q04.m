1;

clear all;

addpath ("./common");

% Directory where LIBSVM .mex files are located
% addpath ("/path/to/libsvm/matlab");

% Polynomial kernel degree
Q = 2;

% Soft-margin SVM
C = 0.01;

% Input data
[X y] = loaddata ("../data/features.train");

% Polynomial kernel
k = 1;

% Degree of the polynomial
Q = 2;

% Hard-margin SVM
C = 0.01;

% Classes for n-vs-all classifiers
N = 0:9;

ein = [];

for i = 1:length(N)
  n = N(i);

  ny = nvsall (n, y);

  % Runs SVM
  model = svm (X, ny, Q, C, k, 0);

  % Computes Ein along with the # of support vectors
  ein(i,:) = [err(model, X, ny), sum(model.nSV)];
end

% Indexes of classifiers with minimum and maximum Ein
imin = find (ein(:,1) == min (ein(:,1)));
imax = find (ein(:,1) == max (ein(:,1)));

printf ("Highest Ein classifier: %d-vs-all (# of SV: %d)\n", N(imax), ein(imax,2));
printf ("Lowest Ein classifier: %d-vs-all (# of SV: %d)\n", N(imin), ein(imin,2));
