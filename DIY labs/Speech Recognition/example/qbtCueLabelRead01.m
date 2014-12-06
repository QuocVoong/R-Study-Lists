waveFile='tapping.wav';
[y, fs, nbits, opts, cueLabel] = wavReadInt(waveFile);
time=((1:length(y))/fs);
plot(time, y); set(gca, 'xlim', [-inf inf]);
axisLimit=axis;
% Display the human-transcribed cue labels
line(cueLabel/fs, axisLimit(4)*ones(length(cueLabel),1), 'color', 'r', 'marker', 'v', 'linestyle', 'none');