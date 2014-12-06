% Remove sinusoid of a specified frequency using LSE

addpath /users/jang/matlab/toolbox/sap

waveFile='D:\dataset\speak2me\TestWaveFilesFromJane\20090413\jane\re_1222_Jane_Cai_1319739.wav';
%waveFile='D:\dataset\speak2me\badWavFiles\20090430\Denver\a045_Denver_3012153.wav';
freq=50;
plotOpt=1;
waveSinusoidRemove(waveFile, 'junk.wav', freq, plotOpt);
