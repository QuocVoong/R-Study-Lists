waveFile='csNthu8b.wav';
frameSize=256;
overlap=0;

[y, fs, nbits]=wavread(waveFile);
y=y*2^nbits/2;
frameMat=enframe(y, frameSize, overlap);
frameNum=size(frameMat, 2);
for i=1:frameNum
	frameMat(:,i)=frameMat(:,i)-round(mean(frameMat(:,i)));		% Zero justification
end
zcr1=sum(frameMat(1:end-1, :).*frameMat(2:end, :)<0);			% Method 1
zcr2=sum(frameMat(1:end-1, :).*frameMat(2:end, :)<=0);			% Method 2
sampleTime=(1:length(y))/fs;
frameNum=size(frameMat, 2);
frameTime=((0:frameNum-1)*(frameSize-overlap)+0.5*frameSize)/fs;

subplot(2,1,1); plot(sampleTime, y); ylabel(waveFile);
subplot(2,1,2); plot(frameTime, zcr1, '.-', frameTime, zcr2, '.-');
title('ZCR'); xlabel('Time (sec)');
legend('Method 1', 'Method 2');