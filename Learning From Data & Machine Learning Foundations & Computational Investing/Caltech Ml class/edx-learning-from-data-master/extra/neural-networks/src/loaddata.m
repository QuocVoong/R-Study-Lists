% Loads the input data
function [X, y] = loaddata (filename)

  % Loads data from filename
  data = load (filename);

  % Number of examples
  N = size (data, 1);

  % Training examples with the added coordinate x0
  X = [ones(N, 1) data(:,1:end-1)];

  % Target label
  y = data(:,end);
end
