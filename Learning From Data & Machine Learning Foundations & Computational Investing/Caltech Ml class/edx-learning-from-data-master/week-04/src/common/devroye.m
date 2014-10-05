% Devroye bound
function epsilon = devroye (N, dvc, delta)
  epsilon = 1;

  do
    oldepsilon = epsilon;

    scale = 1/(2*N);
    implicit = (4*epsilon * (1+epsilon));

    if N <= dvc
      epsilon = sqrt ( scale * (implicit + log ((4 * 4^N) / delta)));
    else
      % Here, we changed the inequality a little bit to make it more stable
      % for larger Ns
      epsilon = sqrt ( scale * (implicit + ((2*dvc * log (N) - ...
                                             log (delta) + log (4)))));
    end

  until (abs (oldepsilon - epsilon) <= 2);
end
