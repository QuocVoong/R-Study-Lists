1;

clear all;
close all;

addpath ("./common");

% Input space
spc = [-1 1];

h = figure (1);

hold on;
grid on;

title ("Legendre Polynomials");

xlabel ("x");
ylabel ("L_n(x)");

% Axis limits
axis (cat (2, spc, [-1.1 1.1]));

% Xs where the legendrepl function will be evaluated
xs = linspace (spc(1), spc(2));

% Plot colors for each curve
plc = "gcbkmr";

for i = 0:5
  plot (xs, arrayfun (@ (x) legendrepl (i, x), xs), "color", plc(i+1));
end

legend ("L_0(x)", "L_1(x)", "L_2(x)", "L_3(x)", "L_4(x)", "L_5(x)", ...
        "location", "southeast");

% Uncomment the following line in order to save the plot to a PNG file
% saveplot (h, 4, 3, "../img/plot_legendre.png")
