cutOffFreq=100;		% Cutoff freq (截止頻率)
filterOrder=5;		% Order of filter (濾波器的階數)
[x, fs, nbits]=wavread('wubai_solicitude.wav');
[b, a]=butter(filterOrder, cutOffFreq/(fs/2), 'low');
x=x(60*fs:90*fs);	% 30 seconds of singing (30 秒歌聲)
y=filter(b, a, x);
% ====== Save wav files (存檔)
wavwrite(x, fs, nbits, 'wubai_solicitude_orig.wav');
wavwrite(y, fs, nbits, sprintf('wubai_solicitude_%d.wav', cutOffFreq));
% ====== Plotting (畫圖)
time=(1:length(x))/fs;
subplot(2,1,1);
plot(time, x);
subplot(2,1,2);
plot(time, y);