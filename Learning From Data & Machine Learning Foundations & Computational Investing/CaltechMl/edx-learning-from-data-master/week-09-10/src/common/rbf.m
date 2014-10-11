% Trains a RBF model
function model = rbf (X, y, gamma, K)
  model.ok = false;
  model.K = K;
  model.gamma = gamma;

  % Number of training examples
  N = length (X);

  % Picks K random points as being the initial centroids
  mus = X(fix (unifrnd (1, N, K, 1)), :);

  % Computes the K clusters using the K-means algorithm
  clusters = kmeans (X, mus);

  if (isbool (clusters))
    return;
  end

  model.clusters = clusters;

  % Computes the phi matrix
  z = phi (clusters, gamma, X);

  % Finds the weights using unregularized linear regression
  model.w = linearreg (z, y, 0);
  model.ok = true;
end
