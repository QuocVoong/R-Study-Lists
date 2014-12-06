close all
waveFile='清華大學資訊系.wav';
frameSize=256;
overlap=128;

[y, fs, nbits]=wavread(waveFile);
fprintf('Length of %s is %g sec.\n', waveFile, length(y)/fs);
framedY=buffer(y, frameSize, overlap);
volume=sum(abs(framedY));
time=(1:length(y))/fs;
frameNum=size(framedY, 2);
frameTime=((0:frameNum-1)*(frameSize-overlap)+0.5*frameSize)/fs;

subplot(2,1,1);
plot(time, y);
title(waveFile);
set(gca, 'xlim', [0, length(y)/fs]);
subplot(2,1,2);
plot(frameTime, volume, '.-');
set(gca, 'xlim', [0, length(y)/fs]);
title('Volume');
