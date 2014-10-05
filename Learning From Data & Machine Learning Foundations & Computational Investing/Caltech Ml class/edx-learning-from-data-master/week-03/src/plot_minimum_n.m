1;

addpath ("./common");

clear all;
close all;
clc;

% This function returns a function that returns the minimum number of examples
% given N, epsilon and the maximum probability bound (delta)
function N = minimum_n (epsilon, delta, M)
  N = (-log (delta) + log (2*M)) / (2 * epsilon^2);
end

h = figure (1);

hold on;
grid on;

title ("Hoeffding Inequality In Terms Of M, {/Symbol e} and {/Symbol d}");
xlabel ("Hypothesis set complexity (M)");
ylabel ("Minimum number of examples (N)");

% Range of M
limits = [1 100];

% Plots the minimum number of examples varying the parameters epsilon and delta
fplot (@ (M) minimum_n (0.05, 0.03, M), limits, "r-");
fplot (@ (M) minimum_n (0.07, 0.05, M), limits, "b-");
fplot (@ (M) minimum_n (0.1, 0.1, M), limits, "g-");

legend ("{/Symbol e}=0.05, {/Symbol d}=0.03", ...
        "{/Symbol e}=0.07, {/Symbol d}=0.05", ...
        "{/Symbol e}=0.1, {/Symbol d}=0.1")

% Uncomment the following line in order to save the plot to a PNG file
% saveplot (h, 4, 3, "../img/plot_minimum_n.png");
