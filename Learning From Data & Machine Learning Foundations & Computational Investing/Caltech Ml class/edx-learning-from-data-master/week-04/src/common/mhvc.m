% Returns the dvc given the growth function gf
function dvc = mhvc (gf)
  dvc = 0;

  % Number of examples
  N = 0;

  while 1
    N += 1;

    if gf (N) < 2^N
      dvc = N-1;
      break;
    end
  end
end
