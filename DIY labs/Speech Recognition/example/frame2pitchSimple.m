function [pitch, frame2, frame3, amdf]=frame2pitch(frame, plotOpt, PP, mainWindow, correctPitch);
%FRAME2PITCH Frame to pitch conversion
%	Usage: pitch=frame2pitch(frame, PP, plotOpt); 
%		frame: Each element is unsigned integer between 0 and 255 (inclusive).
%		plotOpt: 1 for plotting, 0 for not plotting
%		pitch: Output pitch in semitone

%	Roger Jang, 20021201

if nargin<1, selfdemo; return; end
if nargin<2, plotOpt=0; end
if nargin<3, PP=setParam; end
if nargin<4, mainWindow=0; end
if nargin<5, correctPitch=0; end

PP.maxFreq=smtn2frq(PP.maxPitch);
PP.minFreq=smtn2frq(PP.minPitch);

% 求 frame 的平均值為
average=mean(frame);
frame=frame-average;

% frame2: 如果前半音框音量小於後半音框，進行鏡射
frame2=frameFlip(frame, plotOpt);

% frame3: 平滑化
frame3=localAverage(frame2);	% Low-pass filter implemented as local average

% ====== 計算 AMDF 曲線
acf=frame2acf(frame3, PP.maxShift);
amdf=frame2amdf(frame3, PP.maxShift);

% ====== Find ROI
beginIndex=ceil(PP.fs/PP.maxFreq);
endIndex=min(floor(PP.fs/PP.minFreq), PP.maxShift);

% ====== Find local minima in ROI
localMinIndex=[];
for i=beginIndex+1:endIndex-1
	if amdf(i-1)>amdf(i) & amdf(i)<=amdf(i+1)
		localMinIndex=[localMinIndex, i];
	end
end

% ====== 找最小值 in ROI
roi=amdf(beginIndex:endIndex);	% region of interest
[minValue, minIndex]=min(roi);
minIndex=minIndex+beginIndex-1;

% ===== 從 minIndex 往回找可能出現的 2, 3, 4, 5, 6 倍頻
[maxValue, maxIndex]=max(roi);
difthreshold=minValue+floor((maxValue-minValue)/8);
for i=1:length(localMinIndex)
	if amdf(localMinIndex(i)) <= difthreshold
		if abs(floor((minIndex-1+3)/6)-(localMinIndex(i)-1)) <= floor(6/6)
			if plotOpt, fprintf('代換成 6 倍頻！\n'); end
			minIndex=localMinIndex(i);
			break;
		elseif abs(floor((2*minIndex-1+5)/10)-(localMinIndex(i)-1)) <= floor(6/5)
			if plotOpt, fprintf('代換成 5 倍頻！\n'); end
			minIndex=localMinIndex(i);
			break;
		elseif abs(floor((minIndex-1+2)/4)-(localMinIndex(i)-1)) <= floor(6/4)
			if plotOpt, fprintf('代換成 4 倍頻！\n'); end
			minIndex=localMinIndex(i);
			break;
		elseif abs(floor((2*minIndex-1+3)/6)-(localMinIndex(i)-1)) <= floor(6/3)
			if plotOpt, fprintf('代換成 3 倍頻！\n'); end
			minIndex=localMinIndex(i);
			break;
		elseif abs(floor((minIndex-1+1)/2)-(localMinIndex(i)-1)) <= floor(6/2)
			if plotOpt, fprintf('代換成 2 倍頻！\n'); end
			minIndex=localMinIndex(i);
			break;
		end
	end
end

freq=floor((10*PP.fs+floor((minIndex-1)/2))/(minIndex-1));	% 取第一個 minimum 來計算基頻（會爆掉！）
freq=10*floor((PP.fs+floor((minIndex-1)/2))/(minIndex-1));	% 取第一個 minimum 來計算基頻
%fprintf('minIndex=%d\n', minIndex);
%fprintf('freq=%d\n', freq);
pitch=freq2pitch(freq);

% ====== Plot related information
if plotOpt,
	plotNum=3;
	subplot(plotNum,1,1);
	set(plot(1:length(frame), frame, '.-'), 'tag', 'frame'); axis tight; title('Frame');
	subplot(plotNum,1,2);
	set(plot(1:length(acf), acf, '.-'), 'tag', 'acf'); axis tight; title('ACF vector');
	subplot(plotNum,1,3);
	set(plot(1:length(amdf), amdf, '.-'), 'tag', 'amdf'); axis tight; title('AMDF vector');
	amdfAxisH=gca; set(gca, 'tag', 'amdfAxis');
	if ~isempty(localMinIndex)
		localMinIndexH=line(localMinIndex, amdf(localMinIndex), 'linestyle', 'none', 'color', 'k', 'marker', 'o', 'tag', 'localMinIndexH');
	end
	if ~isempty(minIndex)
		minIndexH=line(minIndex, amdf(minIndex), 'linestyle', 'none', 'color', 'r', 'marker', 'o', 'tag', 'minIndexH');
		if correctPitch==0
			minIndex=nan;
		else
			minIndex=round(1+8000/(440*2^((correctPitch/10-69)/12)));
		end
		manualBarH=line(minIndex*[1 1], get(amdfAxisH, 'ylim'), 'color', 'm', 'erase', 'xor', 'tag', 'manualBar');
	end
	line(beginIndex*[1 1], get(gca, 'ylim'), 'color', 'r');
	line(  endIndex*[1 1], get(gca, 'ylim'), 'color', 'r');
	set(gcf, 'name', mfilename);
	
	% 設定滑鼠按鈕的反應動作，以便讓使用者修正 pitch
	if mainWindow>0;
		set(gcf, 'userdata', mainWindow);
		frameWinMouseAction;
	end
end

% ====== selfdemo
function selfdemo
waveFile='waveData/soo.wav';
[y, fs, nbits]=waveFileRead(waveFile);
framedY=buffer2(y, 256, 0);
frame=framedY(:, 250);
PP=setParam;
plotOpt=1;
feval(mfilename, frame, 128, PP, plotOpt);