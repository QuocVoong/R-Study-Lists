% Rademacher penalty bound
function epsilon = rademacher (N, dvc, delta)
  epsilon = sqrt ((2 * log (2 * N * mh (N, dvc))) / N) + ...
            sqrt ((2/N) * log (1/delta)) + (1/N);
end
