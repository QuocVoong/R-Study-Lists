cutOffFreq=1000;	% Cutoff frequency
filterOrder=5;		% Order of filter
[x, fs, nbits]=wavread('wubai_solicitude.wav');
[b, a]=butter(filterOrder, cutOffFreq/(fs/2), 'low');
x=x(60*fs:90*fs);	% 30-second signal
y=filter(b, a, x);
% ====== Save output files
wavwrite(x, fs, nbits, 'wubai_solicitude_orig.wav');
wavwrite(y, fs, nbits, sprintf('wubai_solicitude_%d.wav', cutOffFreq));
% ====== Plot the result
time=(1:length(x))/fs;
subplot(2,1,1);
plot(time, x);
subplot(2,1,2);
plot(time, y);