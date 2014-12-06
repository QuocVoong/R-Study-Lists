% This example demos the effect of FFT approximation

[y, fs]=wavread('welcome.wav');
x=y(2047:2126);
x=y(2047:2326);
n=length(x);
F = (0:n/2)*fs/n;

runNum=5;
for i=1:runNum,
	newX=x(1:2^(i-1):length(x));
	newFs=fs/(2^(i-1));
	X = fft(newX);
	magX = abs(X);
	frameSize=length(newX);

	subplot(runNum,2,2*i-1);
	plot(newX, '.-');
	title('x[n]');
	set(gca, 'xlim', [-inf inf]);

	subplot(runNum,2,2*i);
	freq = (0:frameSize/2)*newFs/frameSize;
	magX = magX(1:length(freq));
	M=nan*F;
	M(1:length(magX))=magX;
	plot(F, M, '.-');
	title('DFT of x[n]')
	axis tight;
end
