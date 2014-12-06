% This example demos the effect of zero-padding of DFT

for i=1:3
	L = 5; N = 20*i;
	x = [ones(1,L), zeros(1,N-L)];
	subplot(3,3,i*3-2);
	stem(x);
	title(sprintf('x[n] with N=%d',N));
	set(gca, 'xlim', [-inf inf]);

	omega=((1:N)-ceil((N+1)/2))*(2*pi/N);
	X = fft(x);
	magX = fftshift(abs(X));
	subplot(3,3,i*3-1);
	plot(omega, magX, '.-');
	title('Magnitude of DFT of x[n]')
	set(gca, 'xlim', [-inf inf]);

	phase=fftshift(angle(X));
	subplot(3,3,i*3);
	plot(omega, phase, '.-');
	title('Phase of DFT of x[n]')
	set(gca, 'xlim', [-inf inf]);
	set(gca, 'ylim', [-pi pi]);
end