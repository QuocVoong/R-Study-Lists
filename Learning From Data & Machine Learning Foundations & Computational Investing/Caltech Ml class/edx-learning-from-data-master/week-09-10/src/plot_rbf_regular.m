1;

clear all;
close all;

addpath ("./common");

% Number of points
N = 100;

% Number of dimensions
d = 2;

% Number of centroids
K = 9;

% How wide the gaussian should be (regularization?)
gamma = 1.5;

% Input space
spc = [-1 1];

% N random examples
X = inputdata (N, d, spc);

% Target labels
y = arrayfun (@ (n) target (X(n,:)), 1:N)';

% Computes the weights using regular RBF with K centers
model = rbf (X, y, gamma, K);

if (model.ok)
  h = figure (1);
  hold on;

  title (sprintf ("Regular RBF ({/Symbol g} = %.1f)", gamma));

  xlabel ("x_1");
  ylabel ("x_2");

  axis (cat (2, spc, spc));

  % Plots the decision boundary
  plotrbfmodel (model, X, spc);

  % Plots the examples
  pos = find (y > 0);
  neg = find (y < 0);

  plot (X(pos,1), X(pos,2), "bo", "MarkerSize", 3, "MarkerFaceColor", "b");
  plot (X(neg,1), X(neg,2), "ro", "MarkerSize", 3, "MarkerFaceColor", "r");

  % Plots the centroids for each cluster
  for k = 1:K
    mu = model.clusters(k).mu;
    plot (mu(1), mu(2), "xk", "MarkerSize", 3);
  end

  % Uncomment the following line in order to save the plot to a PNG file
  % saveplot (h, 4, 3, "../img/plot_rbf_regular.png");
else
  printf ("No solution with %d centroids was found\n", K);
end
