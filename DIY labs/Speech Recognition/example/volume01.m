waveFile='sunday.wav';
frameSize=256;
overlap=128;

[y, fs, nbits]=wavread(waveFile);
fprintf('Length of %s is %g sec.\n', waveFile, length(y)/fs);
frameMat=enframe(y, frameSize, overlap);
frameNum=size(frameMat, 2);

% Compute volume using method 1
volume1=zeros(frameNum, 1);
for i=1:frameNum
	frame=frameMat(:,i);
	frame=frame-median(frame);		% zero-justified
	volume1(i)=sum(abs(frame));             % method 1
end

% Compute volume using method 2
volume2=zeros(frameNum, 1);
for i=1:frameNum
	frame=frameMat(:,i);
	frame=frame-mean(frame);		% zero-justified
	volume2(i)=10*log10(sum(frame.^2)+realmin);	% method 2
end

sampleTime=(1:length(y))/fs;
frameTime=((0:frameNum-1)*(frameSize-overlap)+0.5*frameSize)/fs;
subplot(3,1,1); plot(sampleTime, y); ylabel(waveFile);
subplot(3,1,2); plot(frameTime, volume1, '.-'); ylabel('Volume (Abs. sum)');
subplot(3,1,3); plot(frameTime, volume2, '.-'); ylabel('Volume (Decibels)'); xlabel('Time (sec)');