1;

% Returns the number of terms for a polynomial transform on a 2D coordinate (x,y)
function n = numterms2d (order)

  if (order == 1)
    n = 2;
    return;
  end

  i = 1;
  terms = [order 0];

  while (terms(i,1) > 0)
    terms(i+1,:) = [terms(i,1) - 1, terms(i,2) + 1];
    i += 1;
  end

  n = size (terms, 1) + numterms2d (order - 1);
end

for Q = 1:10
  printf ("Number of terms for the transform with Q=%d -> %d\n", Q, numterms2d (Q));
end
