waveFile = 'soo.wav';
startIndex=round(16538);
frameSize=512;
endIndex=startIndex+frameSize-1;
frame = y(startIndex:endIndex);
hps(frame, 1);