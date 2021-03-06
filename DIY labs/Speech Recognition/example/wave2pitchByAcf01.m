waveFile='soo.wav';
[y, fs, nbits]=wavread(waveFile);
y=y-mean(y);
frameDuration=32;	% Duration (in ms) of a frame
frameSize=round(frameDuration*fs/1000);
overlap=0;
maxShift=frameSize;
maxFreq=1000;
minFreq=40;
n1=round(fs/maxFreq);	% acf(1:n1) will not be used
n2=round(fs/minFreq);	% acf(n2:end) will not be used
frameMat=buffer2(y, frameSize, overlap);
frameNum=size(frameMat, 2);
volume=frame2volume(frameMat);
volumeTh=max(volume)/10;
pitch=0*volume;
for i=1:frameNum
%	fprintf('%d/%d\n', i, frameNum);
	frame=frameMat(:, i);
	acf=frame2acf(frame, maxShift, 1);
	acf(1:n1)=-inf;
	acf(n2:end)=-inf;
	[maxValue, maxIndex]=max(acf);
	freq=fs/(maxIndex-1);
	pitch(i)=freq2pitch(freq);
end

frameTime=frame2sampleIndex(1:frameNum, frameSize, overlap)/fs;
subplot(3,1,1);
plot((1:length(y))/fs, y); set(gca, 'xlim', [-inf inf]);
title('Waveform');
subplot(3,1,2);
plot(frameTime, volume, '.-'); set(gca, 'xlim', [-inf inf]);
line([0, length(y)/fs], volumeTh*[1, 1], 'color', 'r');
title('Volume');
subplot(3,1,3);
pitch2=pitch; pitch2(volume<volumeTh)=nan;	% Volume-thresholded pitch
pitchMedian=nanmedian(pitch2);
pitch2(pitch2>pitchMedian+10)=nan;
pitch2(pitch2<pitchMedian-10)=nan;
%plot(frameTime, pitch, frameTime, pitch2, '.-r'); axis tight;
plot(frameTime, pitch2, '.-r'); axis tight;
xlabel('Time (second)'); ylabel('Semitone');
%title('Original pitch (blue) and volume-thresholded pitch (red)');
title('Volume-thresholded pitch (red)');

timeStep=(frameSize-overlap)/fs;		% No. of pitch points per sec
fs2=16000; nbits2=16;				% Specs for saving the synthesized pitch
wave=pv2wave(pitch2, timeStep, fs2);		% Convert pitch to wave
wavwrite(wave, fs2, nbits2, 'sooPitch.wav');	% Save the wave