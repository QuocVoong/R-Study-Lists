waveFile='tapping.wav';
[y, fs, nbits, opts, cueLabel]=wavReadInt(waveFile);
wObj=waveFile2obj(waveFile);
plotOpt=1;
odPrm=odPrmSet;
onset=odByVol(wObj, odPrm, plotOpt);
subplot(2,1,1);
axisLimit=axis;
% Display the detected tapping
line(onset/fs, axisLimit(3)*ones(length(onset),1), 'color', 'k', 'marker', '^', 'linestyle', 'none'); 
% Display the human-transcribed cue labels
line(cueLabel/fs, axisLimit(4)*ones(length(cueLabel),1), 'color', 'r', 'marker', 'v', 'linestyle', 'none');
