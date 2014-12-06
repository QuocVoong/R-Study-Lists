N=21;
fs=8000;
time=(1:N)'/fs;
x=rand(N,1);
plot(time, x, 'o-');

X=fft(x)/N;

plotNum=fix(N/2)+2;
subplot(plotNum, 1, 1)
plot(time, x, 'o-');
%axis([-inf inf -1 1]);
subplot(plotNum, 1, 2);
N2=(N-1)*5+1;
fineTime=linspace(min(time), max(time), N2);
plot(fineTime, X(1)*ones(N2,1), '.-', time, X(1)*ones(N,1), 'or');
%axis([-inf inf -1 1]);

x2=X(1)*ones(N,1);

for i=1:N/2
	y1=real(X(i+1))*cos(2*pi*(i*fs/N)*fineTime)-imag(X(i+1))*sin(2*pi*(i*fs/N)*fineTime);
	y2=real(X(i+1))*cos(2*pi*(i*fs/N)*time)    -imag(X(i+1))*sin(2*pi*(i*fs/N)*time);
	subplot(plotNum, 1, i+2);
	plot(fineTime, y1, '.-', time, y2, 'or');
%	axis([-inf inf -1 1]);
	x2=x2+y2;
end
sum(abs(x-x2))