load handel.mat;
apObj=audioplayer(y, Fs);
apObj.SampleRate=16000;		% Change the sample rate to 16000
play(apObj);
