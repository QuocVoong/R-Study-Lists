% 顯示音量及過零率
recordViaMic=0;		% 若要自行錄音，將此值改為 1

% ====== Get audio data
if recordViaMic,	% 自行錄音
	fs=16000;				% 取樣頻率
	duration=3;				% 錄音時間
	waveFile='test.wav';	% 音訊檔案名稱
	dataType='uint8';		% 解析度 8 bits/sample
	nbits=8;
	% ====== Record sound
	fprintf('按任意鍵後開始 %g 秒錄音：', duration); pause
	fprintf('錄音中...');
	y=wavrecord(duration*fs, dataType);
	fprintf('錄音結束\n');
else	% 讀取音訊檔案
	waveFile='清華大學資訊系.wav';
	[y, fs, nbits]=wavread(waveFile);
	y=y*2^nbits/2;		% 回復到原先檔案所記載的 uint8 整數值
end

% ====== Plot time-domain audio data
y=double(y);			% MATLAB 6.5 needs this line
y=y-round(mean(y));		% 零點校正
subplot(4,1,1);
plot((1:length(y))/fs, y);
ylabel('Amplitude'); title(waveFile);
axis([-inf, inf, -2^nbits/2, 2^nbits/2]);

% ====== Frame blocking
frameSize=256;
overlap=84;
frameRate=fs/(frameSize-overlap);
framedY=buffer(y, frameSize, overlap);
frameNum=size(framedY, 2);

% ====== Compute volume
volume=10*log10(mean(framedY.^2));
frameTime=(1:frameNum)*(frameSize-overlap)/fs;
subplot(4,1,2);
plot(frameTime, volume, '.-');
title('音量'); ylabel('Volume (Decibel)');
set(gca, 'xlim', [min(frameTime) max(frameTime)])

% ====== Compute zero crossing rate
zcr=sum(framedY(1:end-1, :).*framedY(2:end, :)<=0);
frameTime=(1:frameNum)*(frameSize-overlap)/fs;
subplot(4,1,3);
plot(frameTime, zcr, '.-');
title('過零率'); ylabel('ZCR');
set(gca, 'xlim', [min(frameTime) max(frameTime)])

% ====== Compute zero crossing rate after shifting the original signals
[minVolume, index]=min(volume);
shiftAmount=2*max(abs(framedY(:,index)));	% 以最小音量之音框中的訊號最大絕對值的兩倍為平移量
framedY=framedY-shiftAmount;
zcr=sum(framedY(1:end-1, :).*framedY(2:end, :)<=0);
frameTime=(1:frameNum)*(frameSize-overlap)/fs;
subplot(4,1,4);
plot(frameTime, zcr, '.-');
xlabel('Time (Seconds)');
ylabel('ZCR');
title('平移後之過零率');
set(gca, 'xlim', [min(frameTime) max(frameTime)])

% ====== Play and save the recorded sound
%fprintf('按任意鍵後開始播放：'); pause
%y2=(y-mean(y))/(2^nbits/2);	% 介於 -1 和 1 之間的值
%wavplay(y2,fs);	% 播放音訊
%wavwrite(y2, fs, 8, waveFile);	% 儲存檔案