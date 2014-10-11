1;

addpath ("./common");

clear all;
close all;
clc;

h = figure (1);

hold on;
grid on;

title ("Generalization Bounds Comparison");
xlabel ("N");
ylabel ("{/Symbol e}");

% Number of examples
N = 1:10^4;

% Probability that epsilon will hold
delta = 0.05;

% VC dimension
dvc = 50;

% Plot the generalization bounds in term of N
semilogy (N, arrayfun (@ (n) vc (n, dvc, delta), N), "r-");
semilogy (N, arrayfun (@ (n) rademacher (n, dvc, delta), N), "b-");
semilogy (N, arrayfun (@ (n) parrondo (n, dvc, delta), N), "m-");
semilogy (N, arrayfun (@ (n) devroye (n, dvc, delta), N), "g-");

legend ("Original VC", "Rademacher", "Parrondo", "Devroye");

% Uncomment the following line in order to save the plot to a PNG file
% saveplot (h, 4, 3, "../img/plot_bounds.png");
