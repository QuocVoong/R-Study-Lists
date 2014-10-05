% Returns the phi matrix for RBF
function z = phi (clusters, gamma, X)

  % Number of clusters
  K = size (clusters, 1);

  % Number of training examples
  N = size (X, 1);

  z = [];

  for n = 1:N
    for k = 1:K
      z(n,k) = exp (-gamma * norm (X(n,:) - clusters(k).mu)^2);
    end
  end

  % Adds the bias term (x0)
  z = [ones(N, 1) z];
end
