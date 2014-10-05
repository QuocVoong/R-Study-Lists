% Plots a nonlinear decision boundary based on the weight vector
function plotsvmparams (w, b, Z)
  z1 = linspace (min (Z(:,1)), max (Z(:,1)), 1000)';
  z2 = linspace (min (Z(:,2)), max (Z(:,2)), 1000)';

  negcolor = [1 0.8 0.8];
  poscolor = [0.8 0.8 1];

  [zz1, zz2] = meshgrid (z1, z2);

  Zp = [zz1(:) zz2(:)];
  yp = sign (Zp*w + b);

  neg = find (yp == -1);
  plot (Zp(neg,1), Zp(neg,2), 's', 'color', negcolor, 'MarkerSize', 1, 'MarkerEdgeColor', negcolor, 'MarkerFaceColor', negcolor);

  pos = find(yp == 1);
  plot(Zp(pos,1), Zp(pos,2), 's', 'color', poscolor, 'MarkerSize', 1, 'MarkerEdgeColor', poscolor, 'MarkerFaceColor', poscolor);
end
