% Returns an updated model after computing the feedforward step
function nmodel = nnfeedforward (model, input)
  nmodel = model;

  % For each layer
  for l = 1:length (nmodel.layer)

    % The input of deeper layers are their previous layer
    if l > 1
      input = [1 nmodel.layer(l-1).signal];
    end

    nmodel.layer(l).signal = nmodel.theta (input * nmodel.layer(l).w);
  end
end
