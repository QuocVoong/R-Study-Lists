waveFile='soo.wav';
[y, fs, nbits]=wavread(waveFile);
y=y-mean(y);
frameDuration=32;	% in ms
frameSize=round(frameDuration*fs/1000);
overlap=0;
maxShift=round(frameSize/2);
maxFreq=1000;
minFreq=40;
n1=round(fs/maxFreq);	% amdf(1:n1) will not be used
n2=round(fs/minFreq);	% amdf(n2:end) will not be used
frameMat=buffer2(y, frameSize, overlap);
frameNum=size(frameMat, 2);
volume=frame2volume(frameMat);
volumeTh=max(volume)/8;
pitch=0*volume;
for i=1:frameNum
%	fprintf('%d/%d\n', i, frameNum);
	frame=frameMat(:, i);
	amdf=frame2amdf(frame, maxShift, 3);
	amdf(1:n1)=inf;
	amdf(n2:end)=inf;
	[minValue, minIndex]=min(amdf);
	if minIndex==1
		pitch(i)=0;
	else
		freq=fs/(minIndex-1);
		pitch(i)=freq2pitch(freq);
	end
end

frameTime=frame2sampleIndex(1:frameNum, frameSize, overlap)/fs;
subplot(3,1,1);
plot((1:length(y))/fs, y); set(gca, 'xlim', [-inf inf]);
title('Waveform');
subplot(3,1,2);
plot(frameTime, volume); set(gca, 'xlim', [-inf inf]);
line([0, length(y)/fs], volumeTh*[1, 1], 'color', 'r');
title('Volume');
subplot(3,1,3);
pitch2=pitch; pitch2(volume<volumeTh)=nan;	% Volume-thresholded pitch
plot(frameTime, pitch, frameTime, pitch2, '.-r'); set(gca, 'xlim', [-inf inf]);
xlabel('Time (second)');
title('Original pitch (blue) and volume-thresholded pitch (red)');

pitchRate=fs/(frameSize-overlap);		% No. of pitch points per sec
wave=pitch2waveMex(pitch2, pitchRate, 16000);	% Convert pitch to wave
wavwrite(wave, 16000, 16, 'sooPitch.wav');	% Save the wave