1;

addpath ("./common");

clear all;
close all;
clc;

% Number of points
N = 10;

% VC dimension for each data point q
vc = zeros (10, 1);

% For each q >= 1
for q = 1:10

  % Growth function with q fixed
  vc(q) = mhvc (@ (N) mhq8 (N, q));
end

h = figure (1);

hold on;
grid on;

title ("VC Dimension For Growth Function In Question #8");
xlabel ("q");
ylabel ("d_{vc}");

% Limit axis to spc
axis ([1 10 1 10]);

% Plot the relationship between q and the VC dimension
plot (1:N, vc, "r-");

legend ("hide");

% Uncomment the following line in order to save the plot to a PNG file
% saveplot (h, 4, 3, "../img/plot_vc_q8.png");
