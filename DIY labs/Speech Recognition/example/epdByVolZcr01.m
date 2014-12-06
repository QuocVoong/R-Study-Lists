
waveFile='sunday.wav';
waveFile='nothing.wav';
wObj = waveFile2obj(waveFile);
epdPrm=epdPrmSet;
epdPrm.method='volZcr';
showPlot=1;
endPoint=endPointDetect(wObj, epdPrm, showPlot);