1;

clear all;
close all;

addpath ("./common");

% Input space
spc = [-1 1];

% Enables weight decay. Change this to 1 to enable regularization
wd = 1;

% Regularization parameter
k = -1;

% Loads the training data
[X y] = q2data ("../data/in.dta");

% Applies linear regression with regularization
w = linearreg (X, y, wd, k);

h = figure (1);

hold on;
axis (cat (2, spc, spc));

title (sprintf ("Linear Regression With Regularization (k=%d)", k));

xlabel ("x_1");
ylabel ("x_2");

% Loads the test data
[X y] = q2data ("../data/out.dta");

pos = find (y > 0);
neg = find (y < 0);

% Plots positive and negative examples
plot (X(pos,2), X(pos,3), "ko", "MarkerSize", 3, "MarkerFaceColor", "b");
plot (X(neg,2), X(neg,3), "ko", "MarkerSize", 3, "MarkerFaceColor", "r");

% Plots the decision boundary
plotboundary (w, spc, @q2transform);

% Uncomment the following line in order to save the plot to a PNG file
% saveplot (h, 4, 3, "../img/plot_lr_reg.png")
