% Plot an unit impulse signal

n = -5:5;
x = 0*n;
index=find(n==0);
x(index)=1;

% plot
stem(n, x);
axis([-inf, inf, -0.2, 1.2]);
xlabel('n'); ylabel('x');
title('Delayed Unit Impulse Signal \delta[n-k]');
set(gca, 'xticklabel', {'k-5', 'k-4', 'k-3', 'k-2', 'k-1', 'k', 'k+1', 'k+2', 'k+3', 'k+4', 'k+5'});