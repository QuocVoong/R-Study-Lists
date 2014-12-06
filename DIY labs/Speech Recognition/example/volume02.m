waveFile='sunday.wav';
frameSize=256;
overlap=128;

[y, fs, nbits]=wavread(waveFile);
fprintf('Length of %s is %g sec.\n', waveFile, length(y)/fs);
frameMat=enframe(y, frameSize, overlap);
frameNum=size(frameMat, 2);
opt=frame2volume('defaultOpt');
opt.method='absSum';
volume1=frame2volume(frameMat, opt);
opt.method='decibel';
volume2=frame2volume(frameMat, opt);

sampleTime=(1:length(y))/fs;
frameTime=frame2sampleIndex(1:frameNum, frameSize, overlap)/fs;
subplot(3,1,1); plot(sampleTime, y); ylabel(waveFile);
subplot(3,1,2); plot(frameTime, volume1, '.-'); ylabel('Volume (Abs. sum)');
subplot(3,1,3); plot(frameTime, volume2, '.-'); ylabel('Volume (Decibels)'); xlabel('Time (sec)');