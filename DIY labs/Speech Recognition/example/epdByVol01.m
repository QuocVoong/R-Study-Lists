waveFile='sunday.wav';
wObj = waveFile2obj(waveFile);
epdPrm=epdPrmSet;
epdPrm.method='vol';
showPlot=1;
endPoint=endPointDetect(wObj, epdPrm, showPlot);