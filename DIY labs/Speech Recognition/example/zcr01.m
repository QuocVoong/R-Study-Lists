waveFile='csNthu.wav';
frameSize=256;
overlap=0;
[y, fs, nbits]=wavread(waveFile);
frameMat=enframe(y, frameSize, overlap);
frameNum=size(frameMat, 2);
for i=1:frameNum
	frameMat(:,i)=frameMat(:,i)-mean(frameMat(:,i));	% mean justification
end
zcr=sum(frameMat(1:end-1, :).*frameMat(2:end, :)<0);
sampleTime=(1:length(y))/fs;
frameTime=((0:frameNum-1)*(frameSize-overlap)+0.5*frameSize)/fs;
subplot(2,1,1); plot(sampleTime, y); ylabel('Amplitude'); title(waveFile);
subplot(2,1,2); plot(frameTime, zcr, '.-');
xlabel('Time (sec)'); ylabel('Count'); title('ZCR');