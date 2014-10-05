% Calculates the binary classification error of a hypothesis on a given dataset
function frac = binerr (w, X, y)
  frac = mean (sign (X * w) != y);
end
