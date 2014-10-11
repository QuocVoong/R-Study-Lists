% Growth function for question #8
function n = mhq8(N, q)
  if N == 1
     n = 2;
  else
    if q > N-1
      x = 0;
    else
      x = nchoosek (N-1, q);
    end

    n = 2 * mh (N-1, q) - x;
  end
end
