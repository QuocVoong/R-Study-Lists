% Loads the input data according to the rules explained in question #2
function [X, y] = q2data (filename)

  % Loads data from filename
  data = load (filename);

  % Gets the training examples excluding the target label
  X = q2transform (data(:,1:end-1));

  % Target label
  y = data(:,end);
end
