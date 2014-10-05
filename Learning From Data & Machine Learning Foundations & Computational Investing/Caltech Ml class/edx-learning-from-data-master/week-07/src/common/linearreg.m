% Calculates the linear regression with weight decay regularizer
function w = linearreg (X, y, wd, k)

  % Regularization factor
  lambda = 0;

  if wd == 1
    lambda = 10^k;
  end

  w = inv (X' * X + eye (size (X, 2)) * lambda) * X' * y;
end
