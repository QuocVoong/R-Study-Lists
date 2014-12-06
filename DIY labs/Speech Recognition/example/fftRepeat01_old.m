% This example demos the effect of FFT approximation

[y, fs]=wavread('welcome.wav');
x=y(2047:2126);

runNum=5;
for i=1:runNum,
	repeatedX = x*ones(1,i);
	repeatedX = repeatedX(:);
	frameSize=length(repeatedX);
	X = fft(repeatedX)/N;
	magX = abs(X);

	subplot(runNum,2,2*i-1);
	plot(repeatedX, '.-'); grid on
	title('x[n]');
	set(gca, 'xlim', [-inf inf]);

	subplot(runNum,2,2*i);
	freq = (0:frameSize/2)*fs/frameSize;
	magX = magX(1:length(freq));
	plot(freq, magX, '.-'); grid on
	title('DFT of x[n]')
	axis tight;
end
