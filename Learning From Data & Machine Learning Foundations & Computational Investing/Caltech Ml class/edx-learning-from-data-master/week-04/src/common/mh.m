% Growth function based on N and VC dimension
function k = mh (N, dvc)
  if N <= dvc
    k = 2^N;
  else
    k = N^dvc;
  end
end
