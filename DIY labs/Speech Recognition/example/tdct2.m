close all

[y,fs]=wavread('welcome.wav');
startIndex=1800;
frameSize=256;
range=startIndex:startIndex+frameSize-1;
frame=y(range);

figure;
subplot(2,1,1);
plot(y);
subplot(2,1,2);
plot(range, frame);

figure;
Y=fft(frame);
%Pyy=10*log10(Y.*conj(Y));
Pyy=Y.*conj(Y);
endIndex=floor(frameSize/2)+1;
freq=(0:frameSize-1)*fs;
Pyy=Pyy(1:endIndex);
freq=freq(1:endIndex);
subplot(2,1,1);
plot(freq, Pyy);
xlabel('Frequency (Hz)');
ylabel('Log energy');
title('FFT');
axis tight;

X = dct(frame);
subplot(2,1,2);
plot(X);
title('DCT');
axis tight;