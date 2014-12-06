waveFile='sunday.wav';
%waveFile='/users/jang/matlab/toolbox/sap/noisy.wav';
showPlot=1;
wObj = waveFile2obj(waveFile);
epdPrm=epdPrmSet;
epdPrm.method='volHod';
endPoint=endPointDetect(wObj, epdPrm, showPlot);