[y, fs]=wavread('welcome.wav');
wavplay(1*y, fs, 'sync');	% Playback with original amplitude (播放 1 倍震幅的音訊)
wavplay(3*y, fs, 'sync');	% Playback with 3 times the original amplitude (播放 3 倍震幅的音訊)
wavplay(5*y, fs, 'sync');	% Playback with 5 times the original amplitude (播放 5 倍震幅的音訊)