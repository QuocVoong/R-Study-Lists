1;

clear all;

warning ("off", "Octave:broadcast");
addpath ("./common");

% Input distribution
spc = [-1 1];

% Number of training examples. Change this according to the question
N = 10;

% Number of dimensions
d = 2;

% Hard-margin SVM
C = Inf;

% Number of times the experiment will be computed
runs = 1000;

% Linear kernel
k = svmlinear ();

% Matrix the metrics will be appended to
rundata = [];

for r = 1:runs

  % Generates the training examples for this run
  [X y wf] = inputdata (spc, N, d);

  % Initial weights
  w = zeros (d+1, 1);

  % Runs PLA
  wpla = pla (X, y, w, 1000, 0);

  % Removes the x0, which is not needed for SVM
  X = X(:, 2:size (X, 2));

  % Runs SVM
  [wsvm, sv] = svm (X, y, k, C, 100);

  % Compares the two solutions
  rundata(r,1) = compeout (spc, wf, runs * 5, d, wsvm, wpla);
  rundata(r,2) = length (sv);
end

fprintf ("SVM is better than PLA %.2f%% of the time\n", ...
         mean (rundata(:,1)) * 100);

fprintf ("Average number of support vectors: %.2f\n", mean (rundata(:,2)));
