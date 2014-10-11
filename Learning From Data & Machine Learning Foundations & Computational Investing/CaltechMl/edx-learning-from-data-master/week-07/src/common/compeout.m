% Returns whether w1 has better Eout than w2
function w1better = compeout (spc, wf, N, d, w1, w2)

  % Loops until we find negative and positive examples
  while (1)
    % N random examples
    X = unifrnd (spc(1), spc(2), N, d);

    % Introduces the synthetic dimension x0
    X = [ones(N, 1), X];

    % Target labels
    y = sign (X * wf);

    pos = find (y > 0);
    neg = find (y < 0);

    % Make sure we have both positive and negative examples
    if (any (pos) && any (neg))
      break;
    end
  end

  % Calculates Eout for both w1 and w2
  eout1 = err (w1, X, y);
  eout2 = err (w2, X, y);

  % Returns whether w1 has better Eout than w2
  w1better = (eout1 - eout2) < 0;
end
