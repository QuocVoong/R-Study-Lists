close all
waveFile='soundFork01.wav';

[y, fs, nbits]=wavread(waveFile);
index1=11000;
frameSize=226;
index2=index1+frameSize-1;
segment=y(index1:index2);

subplot(2,1,1);
plot(y); grid on
title(waveFile);
set(gca, 'xlim', [0, length(y)]);
limit=axis;
line(index1*[1 1], limit(3:4), 'color', 'r');
line(index2*[1 1], limit(3:4), 'color', 'r');
subplot(2,1,2);
plot(segment, '.-');
set(gca, 'xlim', [1, index2-index1+1]);
point=[7, 189];
line(point, segment(point), 'marker', 'o', 'color', 'red');

periodCount=5;
fp=((point(2)-point(1))/periodCount)/fs;
ff=fs/((point(2)-point(1))/periodCount);
pitch=69+12*log2(ff/440);
fprintf('Fundamental period = %g second\n', fp);
fprintf('Fundamental frequency = %g Hertz\n', ff);
fprintf('Pitch = %g semitone\n', pitch);