waveFile='sunday.wav';
[wave, fs, nbits] = wavread(waveFile);
frameSize = 256;
overlap = 128;

wave=wave-mean(wave);				% zero-mean substraction
frameMat=buffer2(wave, frameSize, overlap);	% frame blocking
frameNum=size(frameMat, 2);			% no. of frames
specMat=zeros(frameSize/2+1, frameNum);
for i=1:frameNum
	frame=frameMat(:,i);
	[mag, phase, freq, powerDb]=fftOneSide(frame.*hamming(frameSize), fs);
	specMat(:,i)=mag;
end
specVar=var(specMat);
curvea=sum(specMat(2:65, :));
curveb=sum(specMat(66:end, :));
curve1=curvea./curveb;
curve2=10*curveb./curvea;

subplot(3,1,1);
time=(1:length(wave))/fs;
plot(time, wave); ylabel('Amplitude'); title('Waveform');

subplot(3,1,2)
imagesc(specMat); axis xy

subplot(3,1,3);
frameTime=frame2sampleIndex(1:frameNum, frameSize, overlap)/fs;
plot(frameTime', [specVar; curve1; curve2]');
legend('specVar', 'curve1', 'curve2');
xlabel('Time (sec)');