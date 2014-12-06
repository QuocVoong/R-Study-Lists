close all

[y,fs]=wavread('welcome.wav');
startIndex=1800;
frameSize=256;
range=startIndex:startIndex+frameSize-1;
frame=y(range);
realCeps=real(ifft(log(abs(fft(hamming(frameSize).*frame, 512)))));
realCeps=realCeps(1:floor(frameSize/2)+1);
plot(realCeps);
