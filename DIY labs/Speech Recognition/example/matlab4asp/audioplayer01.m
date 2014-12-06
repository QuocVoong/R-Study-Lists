load handel.mat				% Load y and Fs
apObj=audioplayer(y, Fs)		% Create object for audio player
play(apObj, [1 apObj.SampleRate*3]);	% Playback for the first 3 sec
