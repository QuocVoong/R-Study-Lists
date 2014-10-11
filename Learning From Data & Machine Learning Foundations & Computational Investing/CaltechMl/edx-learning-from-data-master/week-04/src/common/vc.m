% Original VC bound
function epsilon = vc (N, dvc, delta)
  epsilon = sqrt ((8/N) * log ((4 * mh (N, dvc)) / delta));
end
