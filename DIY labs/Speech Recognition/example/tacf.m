addpath d:/users/jang/matlab/toolbox/cbmr

wavefile = 'waveData/soo.wav';
%wavefile = 'waveData/together.wav';
[y, fs] = wavread(wavefile);
y = y*128;
time=(1:length(y))/fs;

subplot(4,1,1);
plot(time, y);
title('Waveform');
axis tight

setparam;

% ====== Send to low-pass filter
% Hamming used by default
%b = fir1(pitchParam.lowpassFilterOrder, pitchParam.maxPitchFreq/(fs/2));
%y = filter(b, 1, y);

startIndex = 60000;
startIndex=round(1.5*fs);
frameSize=256;
endIndex=startIndex+frameSize-1;
frame = y(startIndex:endIndex);

ylim=get(gca, 'ylim');
line([time(startIndex), time(startIndex)], ylim, 'color', 'r');
line([time(endIndex), time(endIndex)], ylim, 'color', 'r');

subplot(4,1,2);
h=plot(1:length(frame), frame, 'g-', 1:length(frame), frame, 'k.');
set(h(1), 'linewidth', 2);
title('Frame');
axis tight

out=acfmex(frame);
subplot(4,1,3);
h=plot(1:length(out), out, 'g-', 1:length(out), out, 'k.');
set(h(1), 'linewidth', 2);
title('ACF');
axis tight

out=amdfmex(frame);
subplot(4,1,4);
h=plot(1:length(out), out, 'g-', 1:length(out), out, 'k.');
set(h(1), 'linewidth', 2);
title('AMDF');
axis tight

return

n = 1000;
tic
for i=1:n,
	out1 = acfmex(frame);
end
fprintf('Time for acfmex = %g\n', toc);

for i=1:n;
	out2 = amdfmex(frame);
end
fprintf('Time for amdfmex = %g\n', toc);