function Xt = q2transform (X)

  % Number of examples in data
  N = size (X, 1);

  idx = (1:N)';

  Xt = X;

  % Adds x1^2 term
  Xt = [Xt arrayfun(@ (n) Xt(n,1)^2, idx)];

  % Adds x2^2 term
  Xt = [Xt arrayfun(@ (n) Xt(n,2)^2, idx)];

  % Adds x1x2 term
  Xt = [Xt arrayfun(@ (n) Xt(n,1) * X(n,2), idx)];

  % Adds |x1-x2| term
  Xt = [Xt arrayfun(@ (n) abs (Xt(n,1) - Xt(n,2)), idx)];

  % Adds |x1+x2| term
  Xt = [Xt arrayfun(@ (n) abs (Xt(n,1) + Xt(n,2)), idx)];

  % Adds x0
  Xt = [ones(N, 1) Xt];
end
