% Calculates the bias/variance out-of-sample error decomposition
function [gbar, bias, var] = deceout (N, spc, nsample, target, transform, hypothesis, iter)

  % Calculates the whole data set based on the target function
  X = unifrnd (spc(1), spc(2), N, 1);
  y = arrayfun (target, X);

  % Input transformation
  X = transform (X);

  % Hypothesis for each iteration
  wn = zeros (iter, size (X, 2));

  for n = 1:iter
    % Picks the random points and learn just from them
    xn = fix (unifrnd (1, N, nsample, 1));
    wn(n,:) = hypothesis (X(xn,:), y(xn))';
  end

  % Calculates the mean hypothesis
  gbar = mean (wn);

  % Predicts y given our average hypothesis
  xpred = X * gbar';

  % Difference between gbar and f (bias)
  bias = mean ((xpred - y) .^ 2);

  % Compares each hypothesis g with gbar
  gy = X * wn';
  gvar = [];

  for n = 1:size(gy,2)
    g = gy(:,n);
    gvar(n) = mean ((g - xpred) .^ 2);
  end

  % Mean of the difference between each g and gbar (variance)
  var = mean (gvar);
end
