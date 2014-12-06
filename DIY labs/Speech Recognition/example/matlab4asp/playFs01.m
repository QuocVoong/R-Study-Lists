[y, fs]=wavread('welcome.wav');
wavplay(y, 1.0*fs, 'sync');	% Playback at the original speed (播放 1.0 倍速度的音訊)
wavplay(y, 1.2*fs, 'sync');	% Playback at 1.2 times the original speed (播放 1.2 倍速度的音訊)
wavplay(y, 1.5*fs, 'sync');	% Playback at 1.5 times the original speed (播放 1.5 倍速度的音訊)
wavplay(y, 2.0*fs, 'sync');	% Playback at 2.0 times the original speed (播放 2.0 倍速度的音訊)