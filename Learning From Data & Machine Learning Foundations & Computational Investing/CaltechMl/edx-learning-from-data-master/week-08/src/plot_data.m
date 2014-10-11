1;

clear all;
close all;

addpath ("./common");

% Input data
[X y] = loaddata ("../data/features.train");

h = figure (1);
hold on;

title ("US Postal Service Zip Code Dataset");

xlabel ("symmetry");
ylabel ("intensity");

% Colors for each digit
colors = [0.8 0.8 0.8 ; 0.8 0.4 0.1 ; 0.1 0.4 0.8 ; 0.4 0.8 0.1 ; 0.6 0.1 0.9 ;
          0.9 0.1 0.6 ; 0.9 0.6 0.0 ; 0.5 1.0 0.8 ; 1.0 0.4 0.4 ; 0.1 1.0 0.0 ];

for i = 1:length (colors)
  pos = find (y == i-1);
  plot (X(pos,1), X(pos,2), "o", "Color", colors(i,:), "MarkerSize", 2, ...
        "MarkerFaceColor", colors(i,:));
end

legend ("Digit 0", "Digit 1", "Digit 2", "Digit 3", "Digit 4", "Digit 5", ...
        "Digit 6", "Digit 7", "Digit 8", "Digit 9");

% Uncomment the following line in order to save the plot to a PNG file
% saveplot (h, 4, 3, "../img/plot_data.png");
