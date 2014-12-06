% Plot the operation of convolution

n = -7:7;
x = [0 0 0 0 0 0 0 1 2 3 0 0 0 0 0];

subplot(4,2,7);
stem(n, x);
limit=[min(n), max(n), 0, 5];
axis(limit);
title('Input x[n]');

subplot(4,2,1);
x0=0*x;
x0(8)=x(8);
stem(n, x0);
axis(limit);
h=text(0, x0(8), 'x[0]'); set(h, 'horiz', 'center', 'vertical', 'bottom');

subplot(4,2,2);
y0=0*x;
index=find(x0);
for i=index:length(n)
	y0(i)=x0(index)*exp(-(i-index)/2);
end
stem(n, y0);
axis(limit);
h=text(0, x0(8), 'x[0]*h[n-0]'); set(h, 'vertical', 'bottom');

subplot(4,2,3);
x1=0*x;
x1(9)=x(9);
stem(n, x1);
axis(limit);
h=text(1, x1(9), 'x[1]'); set(h, 'horiz', 'center', 'vertical', 'bottom');

subplot(4,2,4);
y1=0*x;
index=find(x1);
for i=index:length(n)
	y1(i)=x1(index)*exp(-(i-index)/2);
end
stem(n, y1);
axis(limit);
h=text(1, x1(9), 'x[1]*h[n-1]'); set(h, 'vertical', 'bottom');

subplot(4,2,5);
x2=0*x;
x2(10)=x(10);
stem(n, x2);
axis(limit);
h=text(2, x2(10), 'x[2]'); set(h, 'horiz', 'center', 'vertical', 'bottom');

subplot(4,2,6);
y2=0*x;
index=find(x2);
for i=index:length(n)
	y2(i)=x2(index)*exp(-(i-index)/2);
end
stem(n, y2);
axis(limit);
h=text(2, x2(10), 'x[2]*h[n-2]'); set(h, 'vertical', 'bottom');

subplot(4,2,8);
stem(n, y0+y1+y2);
axis(limit);
title('Output y[n] = x[0]*h[n-0] + x[1]*h[n-1] + x[2]*h[n-2]');