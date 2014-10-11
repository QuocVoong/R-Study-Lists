% Returns the classification error for a RBF model for the given test set
function err = errrbf (model, X, y)

  % Creates the phi matrix based on the original input
  Z = phi (model.clusters, model.gamma, X);

  % Calculates the label for that input
  yt = sign (Z * model.w);

  % Average of misclassified points
  err = mean (yt != y);
end
