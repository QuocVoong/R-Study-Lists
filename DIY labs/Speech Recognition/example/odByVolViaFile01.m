waveFile='tappingNoisy.wav';
odPrm=odPrmSet;
plotOpt=1;
[onset, insertCount, deleteCount]=odByVolViaFile(waveFile, odPrm, plotOpt);
fprintf('waveFile=%s, insertCount=%d, deleteCount=%d\n', waveFile, insertCount, deleteCount);
