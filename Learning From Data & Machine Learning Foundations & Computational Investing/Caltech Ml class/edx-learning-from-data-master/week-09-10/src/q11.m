1;

clear all;
close all;

addpath ("./common");

% Transforms the input to the Z space
function Z = transform (X)
  N = length (X);

  % Input transformations
  z1 = arrayfun (@ (n) X(n,2)^2 - 2*X(n,1) - 1, 1:N);
  z2 = arrayfun (@ (n) X(n,1)^2 - 2*X(n,2) + 1, 1:N);

  Z = [z1' z2'];
end

% Training data transformed to the Z space
X = [1 0; 0 1; 0 -1; -1 0; 0 2; 0 -2; -2 0];
Z = transform (X);

% Target labels
y = [-1; -1; -1; 1; 1; 1; 1];

% Plot
h = figure (1);
hold on;

title ("SVM Geometry Intuition");

xlabel ("z_1");
ylabel ("z_2");

axis ([min(Z(:,1)) max(Z(:,1)) min(Z(:,2)) max(Z(:,2))]);

% Proposed solution
b = -0.5;
w = [1; 0];

% Plots the proposed solution
plotsvmparams (w, b, Z);

% Plots the examples
pos = find (y > 0);
neg = find (y < 0);

plot (Z(pos,1), Z(pos,2), "bo", "MarkerSize", 3, "MarkerFaceColor", "b");
plot (Z(neg,1), Z(neg,2), "ro", "MarkerSize", 3, "MarkerFaceColor", "r");

% Uncomment the following line in order to save the plot to a PNG file
% saveplot (h, 4, 3, "../img/plot_q11.png");
