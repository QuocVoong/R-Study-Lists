fs=8000;			% Sampling rate
cutOffFreq=1000;		% Cutoff frequency
allH=[];
for filterOrder=1:8;
	[b, a]=butter(filterOrder, cutOffFreq/(fs/2), 'low');
	% === Plot frequency response
	[h, w]=freqz(b, a);
	allH=[allH, h];
end
plot(w/pi*fs/2, abs(allH)); title('Frequency response of a low-pass utterworth filter');
legend('order=1', 'order=2', 'order=3', 'order=4', 'order=5', 'order=6', 'order=7', 'order=8');
