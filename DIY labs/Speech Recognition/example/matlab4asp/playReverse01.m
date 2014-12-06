[y, fs]=wavread('welcome.wav');
wavplay(y, fs, 'sync');			% Playback of the original signal (播放正常的音訊波形)
wavplay(-y, fs, 'sync');		% Playback of the up-down flipped signal (播放上下顛倒的音訊波形)
wavplay(flipud(y), fs, 'sync');		% Playback of the left-right flipped signal (播放前後顛倒的音訊波形)