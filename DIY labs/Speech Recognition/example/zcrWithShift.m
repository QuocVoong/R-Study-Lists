waveFile='csNthu.wav';
frameSize=256;
overlap=0;
[y, fs, nbits]=wavread(waveFile);
frameMat=enframe(y, frameSize, overlap);
frameNum=size(frameMat,2);
volume=frame2volume(frameMat);
[minVolume, index]=min(volume);
shiftAmount=2*max(abs(frameMat(:,index)));	% shiftAmount is equal to twice the max. abs. sample value within the frame of min. volume
method=1;
zcr1=frame2zcr(frameMat, method);
zcr2=frame2zcr(frameMat, method, shiftAmount);
sampleTime=(1:length(y))/fs;
frameTime=frame2sampleIndex(1:frameNum, frameSize, overlap)/fs;
subplot(2,1,1); plot(sampleTime, y); ylabel('Amplitude'); title(waveFile);
subplot(2,1,2); plot(frameTime, zcr1, '.-', frameTime, zcr2, '.-');
xlabel('Time (sec)'); ylabel('Count'); title('ZCR');
legend('ZCR without shift', 'ZCR with shift');