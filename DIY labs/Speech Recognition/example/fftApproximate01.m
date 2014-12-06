% This example demos the effect of square wave approximation by DFT

figure
L = 15; N = 25;
x = [ones(1,L), zeros(1,N-L)];
frameSize=length(x);

runNum=3;
for i=1:runNum,
	pointNum=ceil(frameSize/(2*runNum)*i);	% Actually 2*pointNum-1 coefs are taken
	X = fft(x);
	magX = abs(X);

	remainIndex=[1:pointNum, frameSize-pointNum+2:frameSize];
	X2=0*X;
	X2(remainIndex)=X(remainIndex);
	x2=ifft(X2);
	x2=real(x2);

	subplot(3,2,2*i-1);
	stem(x);
	hold on
	plot(x2, 'r');
	hold off
	title(sprintf('x[n] and %d-points approximation', 2*pointNum-1));
	axis([-inf,inf,-0.5,1.5])

	subplot(3,2,2*i);
	shiftedMagX=fftshift(magX);
	plot(shiftedMagX, '.-'); axis tight
	title('DFT of x[n]')
	hold on
	temp=ifftshift(1:frameSize);
	ind=temp(remainIndex);
	plot(ind, shiftedMagX(ind), 'or'); grid on
	hold off
end