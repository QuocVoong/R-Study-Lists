% This example demos the effect of zero-padding of DFT
L=5;
for i=1:3
	N=20*i;
	x=[ones(1,L), zeros(1,N-L)];
	subplot(3,3,i*3-2);
	stem(x);
	title(sprintf('x[n] with N=%d',N));
	set(gca, 'xlim', [-inf inf]);

	[mag, phase, freq]=fftOneSide(x);
	subplot(3,3,i*3-1);
	plot(freq, mag, '.-');
	title('Magnitude of DFT of x[n]')
	set(gca, 'xlim', [-inf inf]);

	subplot(3,3,i*3);
	plot(freq, phase, '.-');
	title('Phase of DFT of x[n]')
	set(gca, 'xlim', [-inf inf]);
end