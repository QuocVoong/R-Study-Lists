waveFile='清華大學資訊系.wav';
plotOpt = 1;
[y, fs, nbits] = wavReadInt(waveFile);
endPoint = endPointDetect(y, fs, nbits, plotOpt);