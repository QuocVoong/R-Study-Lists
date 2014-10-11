1;

clear all;
close all;

addpath ("./common");

% Directory where LIBSVM .mex files are located
% addpath ("/path/to/libsvm/matlab");

% Input data
[X y] = loaddata ("../data/features.train");

% 1-vs-5 classification
[X y] = nvsm (1, 5, X, y);

% Polynomial kernel
k = 1;

% Degree of the polynomial
Q = 2;

% Hard-margin SVM
C = Inf;

% Runs SVM
model = svm (X, y, Q, C, k, 0);

h = figure (1);
hold on;

title ("SVM Polynomial Kernel (1 vs 5)");

xlabel ("symmetry");
ylabel ("intensity");

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
% saveplot (h, 4, 3, "../img/plot_libsvm_nvsm_poly.png");
