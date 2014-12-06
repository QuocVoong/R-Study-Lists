close all

[y,fs]=wavread('welcome.wav');
startIndex=1800;
frameSize=256;
range=startIndex:startIndex+frameSize-1;
frame=y(range);


a=lpc(hamming(frameSize).*frame, 16);
h=(1./fft([a zeros(1,512-17)])).';
Phh=20*log10(abs(h));
plot(Phh);