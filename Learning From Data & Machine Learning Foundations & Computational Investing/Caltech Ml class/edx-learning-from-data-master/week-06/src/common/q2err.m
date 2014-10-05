% Calculates the error of a hypothesis on a given dataset
function frac = q2err (w, filename)

  [X y] = q2data(filename);

  % Fraction of misclassified points
  frac = mean (sign (X * w) != y);
end
