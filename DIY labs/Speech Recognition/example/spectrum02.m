waveFile='sunday.wav';
[y, fs, nbits]=wavread(waveFile);
index1=2500;
frameSize=512;
index2=index1+frameSize-1;
frame=y(index1:index2);

subplot(2,1,1); plot(y); grid on
title(waveFile);
line(index1*[1 1], [-1 1], 'color', 'r');
line(index2*[1 1], [-1 1], 'color', 'r');
[mag, phase, freq, powerDb]=fftOneSide(frame.*hamming(frameSize), fs);
subplot(2,2,3); plot(frame, '.-');
subplot(2,2,4); plot(freq, mag);