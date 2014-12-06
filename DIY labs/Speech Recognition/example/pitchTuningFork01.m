waveFile='tuningFork01.wav';
[y, fs, nbits]=wavread(waveFile);
index1=11000;
frameSize=256;
index2=index1+frameSize-1;
frame=y(index1:index2);

subplot(2,1,1); plot(y); grid on
title(waveFile);
line(index1*[1 1], [-1 1], 'color', 'r');
line(index2*[1 1], [-1 1], 'color', 'r');
subplot(2,1,2); plot(frame, '.-'); grid on
point=[7, 189];
line(point, frame(point), 'marker', 'o', 'color', 'red');

periodCount=5;
fp=((point(2)-point(1))/periodCount)/fs;	% fundamental period (in sec)
ff=1/fp;					% fundamental frequency (in Hz)
pitch=69+12*log2(ff/440);			% pitch (in semitone)
fprintf('Fundamental period = %g second\n', fp);
fprintf('Fundamental frequency = %g Hertz\n', ff);
fprintf('Pitch = %g semitone\n', pitch);
