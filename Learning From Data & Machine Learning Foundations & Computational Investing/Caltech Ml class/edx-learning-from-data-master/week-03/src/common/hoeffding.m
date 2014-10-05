% Hoeffding inequality
function p = hoeffding (N, M, epsilon)
  p = 2*M * e^(-2 * epsilon^2 * N);
end
