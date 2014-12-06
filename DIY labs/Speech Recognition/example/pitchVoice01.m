waveFile='csNthu.wav';
[y, fs, nbits]=wavread(waveFile);
index1=11050;
frameSize=512;
index2=index1+frameSize-1;
frame=y(index1:index2);

subplot(2,1,1); plot(y); grid on
title(waveFile);
line(index1*[1 1], [-1 1], 'color', 'r');
line(index2*[1 1], [-1 1], 'color', 'r');
subplot(2,1,2); plot(frame, '.-'); grid on
point=[75, 477];
line(point, frame(point), 'marker', 'o', 'color', 'red');

periodCount=3;
fp=((point(2)-point(1))/periodCount)/fs;	% fundamental period
ff=fs/((point(2)-point(1))/periodCount);	% fundamental frequency
pitch=69+12*log2(ff/440);
fprintf('Fundamental period = %g second\n', fp);
fprintf('Fundamental frequency = %g Hertz\n', ff);
fprintf('Pitch = %g semitone\n', pitch);