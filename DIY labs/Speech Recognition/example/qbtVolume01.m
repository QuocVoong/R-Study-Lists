waveFile='tapping.wav';
wObj=waveFile2obj(waveFile);
y=wObj.signal; fs=wObj.fs; nbits=wObj.nbits;
opt=wave2volume('defaultOpt');
opt.frameSize=320;
opt.overlap=304;
opt.frame2volumeOpt.method='absSum';
volume=wave2volume(wObj, opt);

% Plotting
sampleTime=(1:length(y))/fs;
frameTime=frame2sampleIndex(1:length(volume), opt.frameSize, opt.overlap)/fs;
subplot(2,1,1);
plot(sampleTime, y); xlabel('Time (sec)'); ylabel('Waveform');
subplot(2,1,2);
plot(frameTime, volume); xlabel('Time (sec)'); ylabel('Volume');