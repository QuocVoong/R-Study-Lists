function y = legendrepl (i, x)
  if (i == 0)
    y = 1;
  else if (i == 1)
    y = x;
  else
    y = ((2*i-1) * x * legendrepl (i-1, x) - (i-1) * legendrepl (i-2, x)) / i;
  end
end
