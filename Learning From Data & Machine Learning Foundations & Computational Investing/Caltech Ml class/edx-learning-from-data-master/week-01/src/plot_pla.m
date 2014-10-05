addpath ("./common");

clear all;
close all;
clc;

% Number of dimensions (excluding the synthetic dimension x0, which
% will be added later)
d = 2;

% Number of examples, change this according to the question
N = 100;

h = figure (1);
hold on;

title (sprintf ("Perceptron Learning Algorithm (PLA) for N=%d", N));
xlabel ("x_1");
ylabel ("x_2");

% X/Y range where the examples will be plotted
spc = [-1 1];

% Loops until we find negative and positive examples
while (1)
  % Two random points used in target function f
  fp1 = unifrnd (spc(1), spc(2), 2, 1);
  fp2 = unifrnd (spc(1), spc(2), 2, 1);

  f = @ (x) target (fp1, fp2, x);

  % N random examples
  X = unifrnd (spc(1), spc(2), N, d);

  % Uses the target function to set the desired labels
  y = arrayfun (@ (x, y) sign (f (x) - y), X(:,1), X(:,2));

  % Checks to see if there are both positive and negative examples
  pos = find (y > 0);
  neg = find (y < 0);

  if (any (pos) && any (neg))
    break;
  end
end

% Plots the equation created from the two points
fplot (f, cat(2, spc, spc), "m-");

% Plots the examples
plot (X(pos,1), X(pos,2), "ko", "MarkerSize", 3, "MarkerFaceColor", "b");
plot (X(neg,1), X(neg,2), "ko", "MarkerSize", 3, "MarkerFaceColor", "r");

% Introduce the synthetic dimension x0
X = [ones(N, 1) X];

% Maximum number of iterations
maxiter = 10000;

% Initial weight vector
w = zeros (size (X,2), 1);

% Weight vector w after training
w = pla (X, y, w, maxiter, 0);

% Plots the decision boundary based on the weight vector
plotboundary (w, spc, "g-");
legend ("hide");

% Uncomment the following line in order to save the plot to a PNG file
% saveplot (h, 4, 3, "../img/plot_pla.png")
