function endPoint = endPointDetect01(wave, fs, plotOpt, epdPrm)
% endPointDetect: 根據音量來進行端點偵測
%	Usage: endPoint = endPointDetect(wave, fs, plotOpt, epdPrm)
%		endPoint: 端點（長度為 2 的向量）
%		wave: 輸入之聲音波形
%		fs: 取樣頻率（只有在畫圖才用到）
%		plotOpt: 是否畫出相關圖形
%		epdPrm: 端點偵測的相關參數

%	Roger Jang, 20040413

if nargin==0, selfdemo; return; end
if nargin<2, fs=16000; end
if nargin<3, plotOpt=0; end
if nargin<4,
	epdPrm.frameSize = 256;
	epdPrm.overlap = 0;
	epdPrm.volumeRatio=0.1;
end

frameSize=epdPrm.frameSize;
overlap=epdPrm.overlap;

% ====== Zero adjusted
wave = double(wave);				% 轉成資料型態是 double 的變數
wave = wave-mean(wave);				% 零點校正
frameMat  = buffer(wave, frameSize, overlap);	% 切出音框
frameNum = size(frameMat, 2);			% 音框的個數
volume = sum(abs(frameMat));			% 計算音量
volumeTh = max(volume)*epdPrm.volumeRatio;	% 計算音量門檻值
index = find(volume>volumeTh);			% 找出超過音量門檻值的音框

if isempty(index)				% 若找不到，回傳空矩陣
	endPoint=[];
	return
end

endPoint=([index(1), index(end)]-1)*(frameSize-overlap)+frameSize/2;	% 由 frame index 轉成 sample index

if plotOpt,
	subplot(2,1,1);
	time=(1:length(wave))/fs;
	plot(time, wave);
	axis tight;
	line(time(endPoint(1))*[1 1], [min(wave), max(wave)], 'color', 'm');
	line(time(endPoint(end))*[1 1], [min(wave), max(wave)], 'color', 'm');
	ylabel('Amplitude');
	title('Waveform');

	subplot(2,1,2);
	frameTime=(((1:frameNum)-1)*(frameSize-overlap)+frameSize/2)/fs;
	plot(frameTime, volume, '.-');
	axis tight;
	line([min(frameTime), max(frameTime)], volumeTh*[1 1], 'color', 'r');
	line(frameTime(index(1))*[1 1], [0, max(volume)], 'color', 'm');
	line(frameTime(index(end))*[1 1], [0, max(volume)], 'color', 'm');
	ylabel('Sum of abs.');
	title('Volume');
end

% ====== Self demo
function selfdemo
wavefile='清華大學資訊系.wav';
[wave, fs, nbits] = wavread(wavefile);
wave=wave*(2^nbits/2);
plotOpt = 1;
epdPrm.frameSize = 256;
epdPrm.overlap = 0;
epdPrm.volumeRatio = 0.05;
out = feval(mfilename, wave, fs, plotOpt, epdPrm);