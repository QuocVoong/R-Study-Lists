fs=16000;		% Sampling rate (取樣頻率)
duration=2;		% Recording duration (錄音時間)
channel=1;		% Mono (單聲道)
fprintf('Press any key to start %g seconds of recording...', duration); pause
fprintf('Recording...');
y=wavrecord(duration*fs, fs, channel, 'uint8');		% duration*fs is the number of total sample points
fprintf('Finished recording.\n');
fprintf('Pressy any key to hear the recording...'); pause; fprintf('\n');
wavplay(y,fs);
