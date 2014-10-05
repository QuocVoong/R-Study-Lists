% Returns an updated model after updating the deltas for each unit
function nmodel = nnbackprop (model, x, y)
  nmodel = model;

  % Number of layers
  L = length (nmodel.layer);

  % Output layer
  ol = nmodel.layer(L);

  % For each output unit
  for j = 1:ol.d

    % Computes the delta for the output unit using the squared error measure
    nmodel.layer(L).delta(j) = 2 * (ol.signal - y) * nmodel.thetad (ol.signal);

    % For each hidden layer
    for l = fliplr (1:L-1)

      % For each unit on that layer
      for i = 1:length(nmodel.layer(l).delta)

        % Updates the delta of each unit
        nmodel.layer(l).delta = nmodel.thetad (nmodel.layer(l).signal) .* ...
          (nmodel.layer(l+1).delta * nmodel.layer(l+1).w(2:end,:)');
      end
    end
  end
end
