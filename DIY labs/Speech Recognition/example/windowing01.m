fs=8000;
t=(1:512)'/fs;
f=306.396;

original=sin(2*pi*f*t)+0.2*randn(length(t),1);
windowed=original.*hamming(length(t));
[mag1, phase1, freq1]=fftOneSide(original, fs);
[mag2, phase2, freq2]=fftOneSide(windowed, fs);

subplot(3,2,1); plot(t, original); grid on; axis([-inf inf -1.5 1.5]); title('Original signal');
subplot(3,2,2); plot(t, windowed); grid on; axis([-inf inf -1.5 1.5]); title('Windowed signal');
subplot(3,2,3); plot(freq1, mag1); grid on; title('Energy spectrum (linear scale)');
subplot(3,2,4); plot(freq2, mag2); grid on; title('Energy spectrum (linear scale)');
subplot(3,2,5); plot(freq1, 20*log10(mag1)); grid on; axis([-inf inf -20 60]); title('Energy spectrum (db)');
subplot(3,2,6); plot(freq2, 20*log10(mag2)); grid on; axis([-inf inf -20 60]); title('Energy spectrum (db)');