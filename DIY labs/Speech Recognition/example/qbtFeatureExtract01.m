waveFile='tapping.wav';
wObj=waveFile2obj(waveFile);
y=wObj.signal; fs=wObj.fs; nbits=wObj.nbits;

opt=wave2volume('defaultOpt');
opt.frameSize=round(fs*0.02);
opt.overlap=opt.frameSize-round(fs/1000);
opt.frame2volumeOpt.method='absSum';
volRatio=0.5;
maxTappingPerSec=10;
halfWinWidth=fs/maxTappingPerSec/(opt.frameSize-opt.overlap);	% Half width of the moving window

% ====== Step 1: Apply a volume threshold to have onset candidates
volume=wave2volume(wObj, opt);
frameNum=length(volume);
volTh=max(volume)*volRatio;
onset1=(volume>volTh) & localMax(volume);

% ====== Step 2: Apply a moving window to select the right onset
onset2=onset1;
index=find(onset2);
for i=index
	startIndex=max(i-halfWinWidth, 1);
	endIndex=min(i+halfWinWidth, frameNum);
	[junk, maxIndex]=max(volume(startIndex:endIndex));
	if maxIndex+startIndex-1~=i
		onset2(i)=0;
	end
end

onset=frame2sampleIndex(find(onset2), opt.frameSize, opt.overlap);

% Plotting
sampleTime=(1:length(y))/fs;
frameTime=frame2sampleIndex(1:length(volume), opt.frameSize, opt.overlap)/fs;
subplot(2,1,1);
plot(sampleTime, y);
% Display the detected tapping
axisLimit=axis;
line(onset/fs, axisLimit(3)*ones(length(onset),1), 'color', 'k', 'marker', '^', 'linestyle', 'none');
xlabel('Time (sec)'); ylabel('Waveform');
subplot(2,1,2);
plot(frameTime, volume, '.-');
xlabel('Time (sec)'); ylabel('Volume');
line([frameTime(1), frameTime(end)], volTh*[1 1], 'color', 'k');
line(frameTime(onset1), volume(onset1), 'marker', '.', 'color', 'g', 'linestyle', 'none');
line(frameTime(onset2), volume(onset2), 'marker', '^', 'color', 'k', 'linestyle', 'none');