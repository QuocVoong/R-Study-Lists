waveFile='beautifulSundays.wav';
[wave, fs, nbits] = wavread(waveFile);
frameSize = 512;
overlap = 256;
wave=wave-mean(wave);				% zero-mean substraction
frameMat=buffer2(wave, frameSize, overlap);	% frame blocking
frameNum=size(frameMat, 2);			% no. of frames
n=frameSize/2+1;
for i=1:frameNum
	frame=frameMat(:,i).*hamming(frameSize);
	[mag, phase, freq, powerDb]=fftOneSide(frame, fs);
	ratio(i)=sum(mag(1:floor(n/2)))/sum(mag(floor(n/2)+1:end));
end

subplot(2,1,1);
time=(1:length(wave))/fs;
plot(time, wave); ylabel('Amplitude'); title('Waveform');
subplot(2,1,2);
frameTime=frame2sampleIndex(1:frameNum, frameSize, overlap)/fs;
plot(frameTime, ratio, '.-');
xlabel('Time (sec)');