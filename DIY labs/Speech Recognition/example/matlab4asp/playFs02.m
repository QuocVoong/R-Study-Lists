[y, fs]=wavread('welcome.wav');
wavplay(y, 1.0*fs, 'sync');	% Playback at the original speed (播放 1.0 倍速度的音訊)
wavplay(y, 0.9*fs, 'sync');	% Playback at 0.9 times the original speed (播放 0.9 倍速度的音訊)
wavplay(y, 0.8*fs, 'sync');	% Playback at 0.8 times the original speed (播放 0.8 倍速度的音訊)
wavplay(y, 0.6*fs, 'sync');	% Playback at 0.6 times the original speed (播放 0.6 倍速度的音訊)