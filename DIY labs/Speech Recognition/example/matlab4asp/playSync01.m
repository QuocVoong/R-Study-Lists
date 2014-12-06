[y, fs]=wavread('welcome.wav');
wavplay(y, 1.0*fs, 'sync');		% Synchronous playback (同步播放 1.0 倍速度的音訊)
wavplay(y, 0.8*fs, 'async');	% Asynchronous playback at 0.8 of the original speed (非同步播放 0.8 倍速度的音訊)
wavplay(y, 0.6*fs);				% Asynchronous playback at 0.6 of the original speed (非同步播放 0.6 倍速度的音訊)