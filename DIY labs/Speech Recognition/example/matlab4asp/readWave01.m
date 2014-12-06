[y, fs]=wavread('sunday.wav');
sound(y, fs);		% Playback of the sound data (播放此音訊)
time=(1:length(y))/fs;	% Time vector on x-axis (時間軸的向量)
plot(time, y);		% Plot the waveform w.r.t. time (畫出時間軸上的波形)