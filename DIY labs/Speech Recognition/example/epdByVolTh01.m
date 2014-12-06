waveFile='sunday.wav';
[wave, fs, nbits] = wavread(waveFile);
frameSize = 256;
overlap = 128;

wave=wave-mean(wave);				% zero-mean substraction
frameMat=buffer2(wave, frameSize, overlap);	% frame blocking
frameNum=size(frameMat, 2);			% no. of frames
volume=frame2volume(frameMat);		% volume
volumeTh1=max(volume)*0.1;			% volume threshold 1
volumeTh2=median(volume)*0.1;			% volume threshold 2
volumeTh3=min(volume)*10;			% volume threshold 3
volumeTh4=volume(1)*5;				% volume threshold 4
index1 = find(volume>volumeTh1);
index2 = find(volume>volumeTh2);
index3 = find(volume>volumeTh3);
index4 = find(volume>volumeTh4);
endPoint1=frame2sampleIndex([index1(1), index1(end)], frameSize, overlap);
endPoint2=frame2sampleIndex([index2(1), index2(end)], frameSize, overlap);
endPoint3=frame2sampleIndex([index3(1), index3(end)], frameSize, overlap);
endPoint4=frame2sampleIndex([index4(1), index4(end)], frameSize, overlap);

subplot(2,1,1);
time=(1:length(wave))/fs;
plot(time, wave);
ylabel('Amplitude'); title('Waveform');
axis([-inf inf -1 1]);
line(time(endPoint1(  1))*[1 1], [-1, 1], 'color', 'm');
line(time(endPoint2(  1))*[1 1], [-1, 1], 'color', 'g');
line(time(endPoint3(  1))*[1 1], [-1, 1], 'color', 'k');
line(time(endPoint4(  1))*[1 1], [-1, 1], 'color', 'r');
line(time(endPoint1(end))*[1 1], [-1, 1], 'color', 'm');
line(time(endPoint2(end))*[1 1], [-1, 1], 'color', 'g');
line(time(endPoint3(end))*[1 1], [-1, 1], 'color', 'k');
line(time(endPoint4(end))*[1 1], [-1, 1], 'color', 'r');
legend('Waveform', 'Boundaries by threshold 1', 'Boundaries by threshold 2', 'Boundaries by threshold 3', 'Boundaries by threshold 4');

subplot(2,1,2);
frameTime=frame2sampleIndex(1:frameNum, frameSize, overlap);
plot(frameTime, volume, '.-');
ylabel('Sum of Abs.'); title('Volume');
axis tight;
line([min(frameTime), max(frameTime)], volumeTh1*[1 1], 'color', 'm');
line([min(frameTime), max(frameTime)], volumeTh2*[1 1], 'color', 'g');
line([min(frameTime), max(frameTime)], volumeTh3*[1 1], 'color', 'k');
line([min(frameTime), max(frameTime)], volumeTh4*[1 1], 'color', 'r');
legend('Volume', 'Threshold 1', 'Threshold 2', 'Threshold 3', 'Threshold 4');