function result = nnerr (model, X, y)

  % Number of examples
  N = length (X);

  % Predicted labels
  yp = arrayfun(@ (n) nnpredict (model, X(n,:)), 1:N)';

  result = mean (yp != y);
end
