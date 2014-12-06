waveFile='littleStar.wav';
[y, fs]=wavread(waveFile);

n=512;
t=(1:n)'/fs;
startIndex=30418;
endIndex=startIndex+n-1;

original=y(startIndex:endIndex);
windowed=original.*hamming(n);
[mag1, phase1, freq1]=fftOneSide(original, fs);
[mag2, phase2, freq2]=fftOneSide(windowed, fs);

subplot(3,2,1); plot(original); grid on; axis([-inf inf -1 1]); title('Original signal');
subplot(3,2,2); plot(windowed); grid on; axis([-inf inf -1 1]); title('Windowed signal');
subplot(3,2,3); plot(freq1, mag1); grid on; title('Energy spectrum (linear scale)');
subplot(3,2,4); plot(freq2, mag2); grid on; title('Energy spectrum (linear scale)');
subplot(3,2,5); plot(freq1, 20*log(mag1)); grid on; axis([-inf inf -80 120]); title('Energy spectrum (db)');
subplot(3,2,6); plot(freq2, 20*log(mag2)); grid on; axis([-inf inf -80 120]); title('Energy spectrum (db)');