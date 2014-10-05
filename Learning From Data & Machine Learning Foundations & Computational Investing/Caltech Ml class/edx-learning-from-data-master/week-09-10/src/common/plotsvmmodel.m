% Plots a nonlinear decision boundary based on a SVM model
function plotsvmmodel (model, X)
  xplot = linspace(min(X(:,1)), max(X(:,1)), 1000)';
  yplot = linspace(min(X(:,2)), max(X(:,2)), 1000)';

  axis ([min(X(:,1)) max(X(:,1)) min(X(:,2)) max(X(:,2))]);

  negcolor = [1 0.8 0.8];
  poscolor = [0.8 0.8 1];

  [xi, yi] = meshgrid(xplot, yplot);
  dd = [xi(:),yi(:)];

  [predicted_label accuracy decision_values] = svmpredict (zeros (length (dd), 1), dd, model, '-q');

  neg = find (predicted_label == -1);
  plot (dd(neg,1), dd(neg,2), 's', 'color', negcolor, 'MarkerSize', 1, 'MarkerEdgeColor', negcolor, 'MarkerFaceColor', negcolor);

  pos = find(predicted_label == 1);
  plot(dd(pos,1), dd(pos,2), 's', 'color', poscolor, 'MarkerSize', 1, 'MarkerEdgeColor', poscolor, 'MarkerFaceColor', poscolor);
end
