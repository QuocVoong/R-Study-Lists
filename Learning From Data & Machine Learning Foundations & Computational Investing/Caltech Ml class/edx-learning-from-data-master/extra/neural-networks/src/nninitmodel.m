% Creates the network nodes with initial values for the weights and signals
function layer = nninitmodel (X, Lu)

  % Stores information regarding each layer of the network
  layer = [];

  for l = 1:length (Lu)

    % Number of units on this layer
    layer(l).d = Lu(l);

    % Initial signal and delta for each neuron on this layer
    layer(l).delta = layer(l).signal = zeros (Lu(l), 1)';

    if l == 1
      nprevinputs = size (X, 2);
    else
      nprevinputs = Lu(l-1) + 1;
    end

    % Initializes the weights on this layer with random numbers
    layer(l).w = rand (nprevinputs, Lu(l));
  end
end
