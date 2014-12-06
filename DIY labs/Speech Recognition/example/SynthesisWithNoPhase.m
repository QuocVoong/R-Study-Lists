waveFile='´ÂÃã¥Õ«Ò±m¶³¶¡.wav';
[y, fs, nbits]=wavread(waveFile);
frameSize=256;
overlap=0;
frameMat=buffer(y, frameSize, overlap);

% Observation of a single frame
volume=sum(abs(frameMat));
[maxVol, index]=max(volume);
subplot(3,1,1);
frame=frameMat(:, index);
subplot(2,1,1);
plot(frame);
subplot(2,1,2);
plot(ifft(abs(fft(frame))));


% Observation of the whole wave
frameNum=size(frameMat, 2);
for i=1:frameNum
	frame=frameMat(:,i);
	newFrame=ifft(abs(fft(frame)));
	frameMat(:,i)=newFrame;	
end
newY=frameMat(:);
sound(newY, fs, nbits);

figure
subplot(2,1,1);
plot(y);
subplot(2,1,2);
plot(newY(1:length(y)));

wavwrite(newY, fs, nbits, 'test.wav');