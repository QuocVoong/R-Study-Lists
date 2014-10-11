% Return the new labels for n-vs-m classification
function [nX, ny] = nvsm (n, m, X, y)

  ny = find (y == n);
  my = find (y == m);

  % Only considers examples labeled as n or m
  mny = sort ([ny; my]);

  nX = X (mny,:);
  ny = ty = y (mny);

  ny(find (ty == n)) = 1;
  ny(find (ty == m)) = -1;
end
