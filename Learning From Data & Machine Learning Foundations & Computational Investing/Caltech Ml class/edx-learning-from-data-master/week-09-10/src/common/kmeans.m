% Returns the clusters for the dataset X based on the initial K centroids (mus)
function clusters = kmeans (X, mus)

  % Number of examples
  N = size (X, 1);

  % Number of clusters
  K = size (mus, 1);

  do
    change = 0;

    % Initializes each cluster with no points assigned to them
    clusters = arrayfun (@ (k) struct ("mu", mus(k,:), "xs", []), 1:K);

    % Attribution step
    for n = 1:N

      % Computes the euclidean distance between the point xn and all centroids
      dist = arrayfun (@ (k) norm (X(n,:) - mus(k,:)), 1:K);
      mink = find (dist == min (dist))(1);

      % Assigns the point to the closest centroid
      clusters(mink).xs(end+1,:) = X(n,:);
    end

    % Mean step
    for k = 1:K
      if (clusters(k).xs)
        mu = mean (clusters(k).xs);
      else
        clusters = false;
        return;
      end

      change += sum (abs (clusters(k).mu - mu));
      clusters(k).mu = mus(k,:) = mu;
    end
  until change == 0;

  clusters = clusters';
end
