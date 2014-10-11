% Loads the input data ready for training
function [X y] = loaddata (filename)
  data = load (filename);

  X = data(:,2:end);
  y = data(:,1);
end
