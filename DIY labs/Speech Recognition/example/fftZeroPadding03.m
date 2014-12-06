% This example demos the effect of zero-padding of DFT
[y, fs]=wavread('welcome.wav');
signal=y(2047:2126);		% A full fundamental period
len=length(signal);
for i=1:3
	x=[signal; zeros(len*(i-1), 1)];
	subplot(3,3,i*3-2);
	plot(x, '.-');
%	title(sprintf('x[n] with N=%d',N));
	set(gca, 'xlim', [-inf inf]);

	[mag, phase, freq]=fftOneSide(x);
	subplot(3,3,i*3-1);
	plot(freq, 20*log(mag), '.-');
	title('Magnitude of DFT of x[n]')
	set(gca, 'xlim', [-inf inf]);

	subplot(3,3,i*3);
	plot(freq, phase, '.-');
	title('Phase of DFT of x[n]')
	set(gca, 'xlim', [-inf inf]);
end