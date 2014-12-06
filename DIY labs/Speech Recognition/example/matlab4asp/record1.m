fs=11025;					% 取樣頻率
duration=2;					% 錄音時間
fileName='mywelcome.wav';	% 音訊檔案名稱

fprintf('按任意鍵後開始 %g 秒錄音：', duration);
pause
fprintf('錄音中...');
y=wavrecord(duration*fs, fs, 'uint8');
fprintf('錄音結束\n');

plot((1:length(y))/fs, y);
z=double(y);
figure;
plot((1:length(y))/fs, (z-mean(z))/128);

fprintf('按任意鍵後開始播放：');
pause
wavplay(y,fs);