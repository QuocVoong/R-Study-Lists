addpath ("./common");

clear all;
close all;
clc;

% Data points found by trial and error
X = [1 2 4 6 6 3];
y = [6 4 2 5 7 8];

h = figure (1);
hold on;

title ("Can you shatter these points with the Triangle Model?");
xlabel("x");
ylabel("y");

% Adjust the plot scale
axis ([0 10 0 10]);

% Plot the points
plot (X, y, "ko", "MarkerSize", 3, "MarkerFaceColor", "k");

% Uncomment the following line in order to save the plot to a PNG file
saveplot (h, 4, 3, "../img/plot_triangle_data.png");
