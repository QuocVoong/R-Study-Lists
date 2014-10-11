% Parrondo and Van den Broek bound
function epsilon = parrondo (N, dvc, delta)
  epsilon = vc (N, dvc, delta);

  do
    oldepsilon = epsilon;
    epsilon = sqrt ((1/N) * log ((6 * mh (2*N, dvc)) / delta));
  until (abs (oldepsilon - epsilon) <= 2);
end
