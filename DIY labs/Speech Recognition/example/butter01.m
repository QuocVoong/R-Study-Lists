fs=8000;		% Sampling rate
filterOrder=5;		% Order of filter
cutOffFreq=1000;	% Cutoff frequency
[b, a]=butter(filterOrder, cutOffFreq/(fs/2), 'low');
% === Plot frequency response
[h, w]=freqz(b, a);
plot(w/pi*fs/2, abs(h), '.-'); title('Magnitude frequency response');
grid on