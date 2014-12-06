% Endpoint detection
epdPrm.frameSize = 256;
epdPrm.overlap = 86;
epdPrm.deltaEnergyLevel1 = -20;
epdPrm.deltaEnergyLevel2 = -10;
epdPrm.zcrRatio = 0.2;
fs = 8000;
duration = 3;
plotOpt = 1;
y = recsound('test.wav', duration, fs);
wavefile='test.wav';
%wavefile='清華大學資訊系.wav';
[y, fs, nbits] = wavreadc(wavefile);
y(1:100)=[];
%y=y*(2^nbits/2);
y=y-mean(y);
out = endpoint(y, fs, plotOpt, epdPrm);