% Calculates the error of a hypothesis on a given dataset
function frac = err (w, X, y)
  frac = mean (sign (X * w) != y);
end
