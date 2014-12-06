% This example demos the effect of FFT for purely periodic signals
[y, fs]=wavread('welcome.wav');
x=y(2047:2126);		% A full fundamental period

runNum=5;
for i=1:runNum
	repeatedX = x*ones(1,i);
	signal = repeatedX(:)+0.1;
%	signal=zeros(runNum*length(x), 1);		% Zero-padding version
%	signal(1:length(repeatedX))=repeatedX(:);	% Zero-padding version
	[mag, phase, freq, powerDb]=fftOneSide(signal, fs);
	mag=mag/length(signal);	% Divided by vector length to normalize magnitude (due to the formula used by MATLAB)

	subplot(runNum,2,2*i-1);
	plot(signal, '.-'); grid on
	title('x[n]'); set(gca, 'xlim', [-inf inf]);

	subplot(runNum,2,2*i);
	plot(freq, mag, '.-'); grid on;
%	set(gca, 'yscale', 'log');
	title('DFT of x[n]'); axis tight;
end