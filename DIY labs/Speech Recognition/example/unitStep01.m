% Plot an unit impulse signal

n = -5:5;
x = 0*n;
index=find(n>=0);
x(index)=1;

% plot
stem(n, x);
axis([-inf, inf, -0.2, 1.2]);
xlabel('n');
ylabel('x');
title('Unit Step Signal u[n]');