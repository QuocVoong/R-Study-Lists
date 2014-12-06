% Remove sinusoid of a specified frequency using LSE

addpath /users/jang/matlab/toolbox/sap

inWavFile='D:\dataset\speak2me\TestWaveFilesFromJane\20090413\jane\re_1222_Jane_Cai_1319739.wav';
inWavFile='D:\dataset\speak2me\badWavFiles\20090430\Denver\a045_Denver_3012153.wav';

cutOffFreq=100;
filterOrder=5;
plotOpt=1;
waveHighPassFilter(inWavFile, 'junk.wav', cutOffFreq, filterOrder, plotOpt)
