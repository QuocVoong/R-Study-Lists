1;

clear all;
close all;

addpath ("./common");

% Directory where LIBSVM .mex files are located
% addpath ("/path/to/libsvm/matlab");

% Training data transformed
X = [1 0; 0 1; 0 -1; -1 0; 0 2; 0 -2; -2 0];

% Target labels
y = [-1; -1; -1; 1; 1; 1; 1];

% Polynomial kernel
kt = 1;

% Degree of the polynomial
Q = 2;

% Hard-margin SVM
C = Inf;

% Solves the SVM
model = svm (X, y, 0, Q);

h = figure (1);
hold on;

title ("SVM With Polynomial Kernel (Q=2)");

xlabel ("x_1");
ylabel ("x_2");

axis ([min(X(:,1)) max(X(:,1)) min(X(:,2)) max(X(:,2))]);

% Plots the decision boundary
plotsvmmodel (model,X);

% Plots the examples
pos = find (y > 0);
neg = find (y < 0);

plot (X(pos,1), X(pos,2), "bo", "MarkerSize", 3, "MarkerFaceColor", "b");
plot (X(neg,1), X(neg,2), "ro", "MarkerSize", 3, "MarkerFaceColor", "r");

% Highlights the support vectors
p = X(model.sv_indices,:);
plot (p(:, 1), p(:, 2), "ko", "MarkerSize", 5);

% Uncomment the following line in order to save the plot to a PNG file
% saveplot (h, 4, 3, "../img/plot_q12.png");
