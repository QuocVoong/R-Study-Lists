% This example demos the effect of FFT approximation

n=10;
x=rand(n, 1);
X=fft(x);

sinusoidNum=5;
sinusoid1(:,1)=X(1)*ones(length(1:n),1);
sinusoid2(:,1)=X(1)*ones(length(1:0.1:n),1);
legendStr={'Comp 0'};
for i=2:sinusoidNum
	sinusoid1(:,i)=2*abs(X(i))*cos(2*pi*(0:n-1)'*i/n + angle(X(i)));
	sinusoid2(:,i)=2*abs(X(i))*cos(2*pi*(0:0.1:n-1)'*i/n + angle(X(i)));
	legendStr={legendStr{:}, ['Comp ', int2str(i-1)]};
end

y1=sum(sinusoid1,2);
y2=sum(sinusoid2,2);
subplot(2,1,1)
plot(1:n, x, 'o-', 1:n, y1, 'o-', 1:0.1:n, y2);
legend('Original', 'Approximated');
grid on
subplot(2,1,2)
plot(0:n-1, sinusoid1, 'o');
hold on
plot(0:0.1:n-1, sinusoid2);
hold off
grid on
title(sprintf('%d sinusoidal components', sinusoidNum));
legend(legendStr{:});