% Calculates the error of a SVM model on a given dataset
function frac = err (model, X, y)
  [_, accuracy, _] = svmpredict (y, X, model, '-q');
  frac = 1 - accuracy(1) / 100;
end
