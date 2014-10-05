% Generates a Nxd matrix with random values uniformly distributed in spc
function X = inputdata (N, d, spc)
  X = unifrnd (spc(1), spc(2), N, d);
end
