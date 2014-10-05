1;

clear all;
close all;

warning ("off", "Octave:broadcast");
addpath ("./common");

% Input distribution
spc = [-1 1];

% Number of training examples
N = 50;

% Number of dimensions
d = 2;

% Hard-margin SVM
C = Inf;

% Number of times the experiment will be computed
runs = 1000;

% Linear kernel
k = svmlinear ();

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

h = figure (1);

hold on;

title ("PLA vs SVM");

xlabel ("x_1");
ylabel ("x_2");
axis (cat (2, spc, spc));

% Plots the examples
pos = find (y > 0);
neg = find (y < 0);

plot (X(pos,1), X(pos,2), "bo", "MarkerSize", 3, "MarkerFaceColor", "b");
plot (X(neg,1), X(neg,2), "ro", "MarkerSize", 3, "MarkerFaceColor", "r");

% Plots the target decision boundary
% plotboundary (wf, spc, "m-");

% Plots the decision boundary given by PLA
plotboundary (wpla, spc, "g-");

% Plots the decision boundary given by SVM
plotboundary (wsvm, spc, "k-");

% Highlights the support vectors
p = X(sv,:);
plot (p(:, 1), p(:, 2), "ko", "MarkerSize", 5);

legend ("hide");

% Uncomment the following line in order to save the plot to a PNG file
% saveplot (h, 4, 3, "../img/plot_svm_pla.png")
