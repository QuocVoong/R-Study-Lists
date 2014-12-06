% Plot a sinusoidal signal

n = 0:40;
omega=0.3;
x = sin(omega*n);

% plot
stem(n, x);
axis([-inf, inf, -1.2, 1.2]);
xlabel('n');
ylabel('x');
title('sin[\omega n]');