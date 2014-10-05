1;

clear all;
close all;

addpath ("./common");

% Number of points
N = 100;

% Number of dimensions
d = 2;

% Number of centroids
K = 6;

% Input space
spc = [-1 1];

% N random examples
X = inputdata (N, d, spc);

% Picks K random points as being the initial centroids
mus = X(fix (unifrnd (1, N, K, 1)), :);

% Computes the K clusters using the K-means algorithm
clusters = kmeans (X, mus);

if (!isbool (clusters))
  h = figure (1);
  hold on;

  title ( sprintf ("K-means Algorithm (K=%d)", K));

  xlabel ("x_1");
  ylabel ("x_2");

  % Color map for each cluster
  kcolors = "brgmck";

  for k = 1:length (clusters)
    % Centroid and its points
    mu = clusters(k).mu;
    xs = clusters(k).xs;

    % Plots the centroid along with its points
    plot (mu(1), mu(2), "x", "Color", kcolors(k), "MarkerSize", 3, "MarkerFaceColor", kcolors(k));
    plot (xs(:,1), xs(:,2), "o", "Color", kcolors(k), "MarkerSize", 3, "MarkerFaceColor", kcolors(k));
  end
else
  printf ("Cannot split the data set into %d clusters\n", K);
end

% Uncomment the following line in order to save the plot to a PNG file
% saveplot (h, 4, 3, "../img/plot_kmeans.png");
