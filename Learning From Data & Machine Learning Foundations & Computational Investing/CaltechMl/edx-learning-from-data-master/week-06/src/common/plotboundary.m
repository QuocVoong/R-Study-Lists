function plotboundary (w, spc, transfunc)
  x = y = linspace (spc(1), spc(2));
  [xx, yy] = meshgrid (x', y');

  func = @ (x, y) sign (transfunc ([x y]) * w);

  contour (xx, yy, arrayfun (func, xx, yy), 1, "m");
end
