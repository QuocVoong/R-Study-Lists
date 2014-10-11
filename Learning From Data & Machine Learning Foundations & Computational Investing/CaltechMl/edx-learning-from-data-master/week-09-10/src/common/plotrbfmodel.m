% Plots a nonlinear decision boundary based on the weight vector
function plotrbfmodel (model, X, spc)
  x1 = x2 = linspace (spc(1), spc(2), 300)';

  negcolor = [1 0.8 0.8];
  poscolor = [0.8 0.8 1];

  [xx1, xx2] = meshgrid (x1, x2);

  Xp = [xx1(:) xx2(:)];

  % Creates the phi matrix based on the original input
  Zp = phi (model.clusters, model.gamma, Xp);

  % Calculates the label for that input
  yp = sign (Zp * model.w);

  neg = find (yp == -1);
  plot (Xp(neg,1), Xp(neg,2), 's', 'color', negcolor, 'MarkerSize', 1, 'MarkerEdgeColor', negcolor, 'MarkerFaceColor', negcolor);

  pos = find(yp == 1);
  plot(Xp(pos,1), Xp(pos,2), 's', 'color', poscolor, 'MarkerSize', 1, 'MarkerEdgeColor', poscolor, 'MarkerFaceColor', poscolor);
end
