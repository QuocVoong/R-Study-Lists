% Calculates the Eout for weight vector w
function diff = eout (d, spc, f, w, count)
  X = unifrnd (spc(1), spc(2), count, d);
  X = [ones(count, 1) X];

  y  = arrayfun (@ (x, y) sign (f (x) - y), X(:,2), X(:,3));
  hy = misclassified (X, y, w);

  diff = length (hy) / length (X);
end
