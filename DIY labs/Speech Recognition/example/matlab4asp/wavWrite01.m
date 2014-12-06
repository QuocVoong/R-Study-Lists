fs=11025;		% Sampling rate (取樣頻率)
duration=2;		% Recording duration (錄音時間)
waveFile='test.wav';	% Wav file to be saved (欲儲存的 wav 檔案)
fprintf('Press any key to start %g seconds of recording...', duration); pause
fprintf('Recording...');
y=wavrecord(duration*fs, fs);
fprintf('Finished recording.\n');
fprintf('Press any key to save the sound data to %s...', waveFile); pause
nbits=8;			% Bit resolution (每點的解析度為 8-bit)
wavwrite(y, fs, nbits, waveFile);
fprintf('Finished writing %s\n', waveFile);
fprintf('Press any key to play %s...\n', waveFile);
dos(['start ', waveFile]);	% Start the application for .wav file (開啟與 wav 檔案對應的應用程式)