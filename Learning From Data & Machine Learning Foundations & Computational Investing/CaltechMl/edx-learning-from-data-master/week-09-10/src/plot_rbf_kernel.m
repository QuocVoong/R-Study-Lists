1;

clear all;
close all;

addpath ("./common");

% Directory where LIBSVM .mex files are located
% addpath ("/path/to/libsvm/matlab");

% Number of points
N = 100;

% Number of dimensions
d = 2;

% Gamma
gamma = 1.5;

% Input space
spc = [-1 1];

% N random examples
X = inputdata (N, d, spc);

% Target labels
y = arrayfun (@ (n) target (X(n,:)), 1:N)';

% Runs hard-margin SVM with RBF kernel
model = svm (X, y, gamma, 0);

h = figure (1);
hold on;

title (sprintf ("SVM With RBF Kernel ({/Symbol g} = %.1f)", gamma));

xlabel ("x_1");
ylabel ("x_2");

axis (cat (2, spc, spc));

% Plots the decision boundary
plotsvmmodel (model, X);

% Plots the examples
pos = find (y > 0);
neg = find (y < 0);

plot (X(pos,1), X(pos,2), "bo", "MarkerSize", 3, "MarkerFaceColor", "b");
plot (X(neg,1), X(neg,2), "ro", "MarkerSize", 3, "MarkerFaceColor", "r");

% Highlights the support vectors
p = X(model.sv_indices,:);
plot (p(:, 1), p(:, 2), "ko", "MarkerSize", 5);

% Uncomment the following line in order to save the plot to a PNG file
% saveplot (h, 4, 3, "../img/plot_rbf_kernel.png");
