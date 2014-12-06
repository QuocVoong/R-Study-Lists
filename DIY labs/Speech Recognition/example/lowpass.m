maxFreq=1047;
fs=11025;
order=10;
b=fir1(order, maxFreq/(fs/2)); 
freqz(b, 1, 100);

figure;
h=freqz(b, 1, 100);
subplot(2,1,1);
plot(10*log10(h.*conj(h)));
subplot(2,1,2);
plot(h.*conj(h));


waveFile='welcome.wav';
[y, fs]=wavread(waveFile);

fprintf('Press return to hear the original signal...\n'); pause
sound(y, fs);

y2 = filter(b, 1, y);

fprintf('Press return to hear the low-passed signal...\n'); pause
sound(y2, fs);

