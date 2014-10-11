% Loads the input data from a file
function [X, y] = loaddata (filename)

  % Loads data from filename
  data = load (filename);

  % Gets the training examples excluding the target label
  X = data(:,2:end);

  % Target label
  y = data(:,1);
end
