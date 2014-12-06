% This example demos the effect of FFT approximation

[y, fs]=wavread('welcome.wav');
x=y(2047:2047+237-1);

figure
frameSize=length(x);

runNum=3;
for i=1:runNum,
	pointNum=ceil(frameSize/(8*runNum)*i);	% Actually 2*pointNum-1 coefs are taken
	X = fft(x);
	magX = abs(X);

	remainIndex=[1:pointNum, frameSize-pointNum+2:frameSize];
	X2=0*X;
	X2(remainIndex)=X(remainIndex);
	x2=ifft(X2);
	x2=real(x2);

	subplot(3,2,2*i-1);
	plot(x, '.-');
	hold on
	plot(x2, 'r');
	hold off
	title(sprintf('x[n] and %d-points approximation', 2*pointNum-1));
	set(gca, 'xlim', [-inf inf]);

	subplot(3,2,2*i);
	shiftedMagX=fftshift(magX);
	plot(shiftedMagX, '.-');
	title('DFT of x[n]')
	hold on
	temp=ifftshift(1:frameSize);
	ind=temp(remainIndex);
	plot(ind, shiftedMagX(ind), 'or'); grid on
	hold off
	set(gca, 'xlim', [-inf inf]);
end

