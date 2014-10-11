% Performs the required input transformation in questions 8-10
function Xt = transform (X)
  Xt = X;
  idx = (1:length (Xt))';

  % x1 * x2
  Xt = [Xt arrayfun(@ (n) Xt(n,1) * Xt(n,2), idx)];

  % x1^2
  Xt = [Xt arrayfun(@ (n) Xt(n,1)^2, idx)];

  % x2^2
  Xt = [Xt arrayfun(@ (n) Xt(n,2)^2, idx)];

  % x0
  Xt = [ones(length (Xt), 1) Xt];
end
