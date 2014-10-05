% Return the new labels for n-vs-all classification
function ny = nvsall (n, y)
  ny = y;

  ny(find (y == n)) = 1;
  ny(find (y != n)) = -1;
end
