% Calculates the linear regression with weight decay regularizer
function w = linearreg (X, y, lambda)
  w = inv (X' * X + eye (size (X, 2)) * lambda) * X' * y;
end
