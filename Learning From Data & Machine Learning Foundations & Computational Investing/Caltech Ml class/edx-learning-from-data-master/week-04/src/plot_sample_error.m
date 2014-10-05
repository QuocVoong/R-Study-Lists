1;

clear all;
close all;
clc;

addpath ("./common");

% Number of iterations
iter = 200;

% Input distribution
spc = [-1 1];

% Number of points on each sample
nsample = 2;

% Number of examples overall
N = 10^2;

% Target function
target = @ (x) sin (pi * x);

% Hypothesis function
hypothesis = @ (X, y) linearreg (X, y);

% Possible hypothesis sets

% Constant
transform = @ (X) ones (size (X, 1), 1);

% Line that passes through origin (0, 0)
% transform = @ (X) X;

% Line with intercept
% transform = @ (X) [ones(size (X, 1), 1) X];

% Curve that passes through origin (0, 0)
% transform = @ (X) X.^2;

% Curve with intercept
% transform = @ (X) [ones(size (X, 1), 1), X.^2];

% Calculates the whole data set based on the target function
X = unifrnd (spc(1), spc(2), N, 1);
y = arrayfun (target, X);

% Input transformation
X = transform (X);

h = figure (1);
hold on;

title ( sprintf ("Hypothesis Set Error With Sample N=%d", nsample));
xlabel ("x");
ylabel ("y");

% Limit axis to spc
axis (cat (2, spc, spc));

for i = 1:iter

  % Picks the random points and learn just from them
  xn = fix (unifrnd (1, N, nsample, 1));
  wn = hypothesis (X(xn,:), y(xn));

  % Function that plots the decision boundary wn
  wf = @ (x) transform (x) * wn;

  sx = linspace (spc(1), spc(2));
  sy = arrayfun (wf, sx);

  line (sx, sy, "color", [0.8 0.8 0.8]);
end

% Plots the target function for reference
sx = linspace (spc(1), spc(2));
sy = arrayfun (target, sx);

line (sx, sy, "color", "r", "linewidth", 3);

legend ("hide");

% Uncomment the following line in order to save the plot to a PNG file
% saveplot (h, 4, 3, "../img/plot_sample_error.png");
