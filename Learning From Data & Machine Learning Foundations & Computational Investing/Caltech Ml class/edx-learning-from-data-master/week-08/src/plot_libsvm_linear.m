1;

clear all;
close all;

addpath ("./common");

% Directory where LIBSVM .mex files are located
% addpath ("/path/to/libsvm/matlab");

% Input distribution
spc = [-1 1];

% Number of training examples
N = 50;

% Number of dimensions
d = 2;

% Linear kernel
k = 0;

% Hard-margin SVM
C = Inf;

% Generates the training examples for this run
[X y wf] = inputdata (spc, N, d);

% Initial weights
w = zeros (d+1, 1);

% Removes the x0, which is not needed for SVM
X = X(:, 2:size (X, 2));

% Runs SVM
model = svm (X, y, 0, C, k, 0);

h = figure (1);
hold on;

title ("SVM Linear Kernel");

xlabel ("x_1");
ylabel ("x_2");
axis (cat (2, spc, spc));

% Plots the decision boundary given by SVM
plotboundary (model, X);

% Plots the examples
pos = find (y > 0);
neg = find (y < 0);

plot (X(pos,1), X(pos,2), "bo", "MarkerSize", 3, "MarkerFaceColor", "b");
plot (X(neg,1), X(neg,2), "ro", "MarkerSize", 3, "MarkerFaceColor", "r");

% Highlights the support vectors
p = X(model.sv_indices,:);
plot (p(:, 1), p(:, 2), "ko", "MarkerSize", 5);

legend ("hide");

% Uncomment the following line in order to save the plot to a PNG file
% saveplot (h, 4, 3, "../img/plot_libsvm_linear.png");
