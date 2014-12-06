waveFile='soo.wav';
[y, fs, nbits]=wavread(waveFile);
frameSize=256;
frameMat=buffer(y, frameSize, 0);
frame=frameMat(:, 292);
method=1;
maxShift=length(frame)/2;
plotOpt=1;
frame2acfOverAmdf(frame, maxShift, method, plotOpt);