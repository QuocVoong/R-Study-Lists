wavefile='清華大學資訊系.wav';
[wave, fs, nbits] = wavReadInt(wavefile);	% wave 是整數

frameSize = 256;
overlap = 128;

wave=wave-mean(wave);				% 零點校正
frameMat=buffer2(wave, frameSize, overlap);	% 切出音框
frameNum=size(frameMat, 2);			% 音框的個數
volume=sum(abs(frameMat));			% 計算音量
volumeTh1=max(volume)*0.1;			% 音量門檻值之一
volumeTh2=min(volume)*5;			% 音量門檻值之二
volumeTh3=volume(1)*4;				% 音量門檻值之三
index1 = find(volume>volumeTh1);		% 找出超過音量門檻值之一的音框
index2 = find(volume>volumeTh2);		% 找出超過音量門檻值之二的音框
index3 = find(volume>volumeTh3);		% 找出超過音量門檻值之三的音框
endPoint1=frame2sampleIndex([index1(1), index1(end)], frameSize, overlap);	% 由 frame index 轉成 sample index
endPoint2=frame2sampleIndex([index2(1), index2(end)], frameSize, overlap);	% 由 frame index 轉成 sample index
endPoint3=frame2sampleIndex([index3(1), index3(end)], frameSize, overlap);	% 由 frame index 轉成 sample index

subplot(2,1,1);
time=(1:length(wave))/fs;
plot(time, wave);
ylabel('Amplitude'); title('Waveform');
axis([-inf inf -2^nbits/2 2^nbits/2]);
line(time(endPoint1(  1))*[1 1], 2^nbits*[-1, 1], 'color', 'm');
line(time(endPoint1(end))*[1 1], 2^nbits*[-1, 1], 'color', 'm');
line(time(endPoint2(  1))*[1 1], 2^nbits*[-1, 1], 'color', 'g');
line(time(endPoint2(end))*[1 1], 2^nbits*[-1, 1], 'color', 'g');
line(time(endPoint3(  1))*[1 1], 2^nbits*[-1, 1], 'color', 'k');
line(time(endPoint3(end))*[1 1], 2^nbits*[-1, 1], 'color', 'k');

subplot(2,1,2);
frameTime=frame2sampleIndex(1:frameNum, frameSize, overlap);
plot(frameTime, volume, '.-');
ylabel('Sum of Abs.'); title('Volume');
axis tight;
line([min(frameTime), max(frameTime)], volumeTh1*[1 1], 'color', 'm');
line(frameTime(index1(  1))*[1 1], [0, max(volume)], 'color', 'm');
line(frameTime(index1(end))*[1 1], [0, max(volume)], 'color', 'm');
line([min(frameTime), max(frameTime)], volumeTh2*[1 1], 'color', 'g');
line(frameTime(index2(  1))*[1 1], [0, max(volume)], 'color', 'g');
line(frameTime(index2(end))*[1 1], [0, max(volume)], 'color', 'g');
line([min(frameTime), max(frameTime)], volumeTh3*[1 1], 'color', 'k');
line(frameTime(index3(  1))*[1 1], [0, max(volume)], 'color', 'k');
line(frameTime(index3(end))*[1 1], [0, max(volume)], 'color', 'k');