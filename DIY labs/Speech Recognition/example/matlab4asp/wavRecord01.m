fs=16000;		% Sampling rate (取樣頻率)
duration=2;		% Recording duration (錄音時間)
fprintf('Press any key to start %g seconds of recording...', duration); pause
fprintf('Recording...');
y=wavrecord(duration*fs, fs);	% duration*fs is the total number of sample points
fprintf('Finished recording.\n');
fprintf('Press any key to play the recording...'); pause; fprintf('\n');
wavplay(y,fs);