waveFile='tappingNoisy.wav';
odPrm=odPrmSet;
odPrm.useHighPassFilter=1;
odPrm.volRatio=0.2;
plotOpt=1;
[onset, insertCount, deleteCount]=odByVolViaFile(waveFile, odPrm, plotOpt);
fprintf('waveFile=%s, insertCount=%d, deleteCount=%d\n', waveFile, insertCount, deleteCount);
