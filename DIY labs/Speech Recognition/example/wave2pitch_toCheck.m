function [pitch1, pitch2, pitch3]=wave2pitch(wave, plotOpt, PP, waveFile);
%WAVE2PITCH Wave to pitch conversion
%	Usage: pitch=wave2pitch(wave, PP, plotOpt); 
%		wave: Each element is unsigned integer between 0 and 255 (inclusive).
%		plotOpt: 1 for plotting, 0 for not plotting
%		pitch: Output pitch in semitone

%	Roger Jang, 20021201

if nargin<1, selfdemo; return; end
if nargin<2, plotOpt=0; end
if nargin<3, PP=setParam; PP.frame2pitchFcn='frame2pitchSimple'; end
if nargin<4, waveFile=''; end	% 此參數是為了要顯示手動標的 pitch

if isstr(wave)
	waveFile=wave;
	[y, PP.fs, nbits]=waveFileRead(waveFile);
else
	y=wave;
end
	
framedY=buffer2(y, PP.frameSize, PP.overlap);
frameNum=size(framedY, 2);
pitch1=zeros(frameNum, 1);
volume=zeros(frameNum, 1);

% ====== Compute raw pitch and volume
for i=1:frameNum,
	fprintf('%g/%g\n', i, frameNum);
	pitch1(i)=feval(PP.frame2pitchFcn, framedY(:,i), 0, PP);
	volume(i)=frame2volume(framedY(:,i));
end
PP.volThreshold=getVolumeThreshold(volume);
lowVolIndex=find(volume<PP.volThreshold);

% 若相關的手動標示 pitch 檔案已存在，讀入並畫出
[a,b,c,d]=fileparts(waveFile);
pitchFile=[a, '/', b, '.pitch'];
if exist(pitchFile)==2
	copyfile(pitchFile, [tempdir, 'oldPitch.txt']);
	load([tempdir, 'oldPitch.txt'])
	pitch1manual=oldPitch;	% 手動標示的 pitch
else
	pitch1manual=pitch1;	% 電腦算的 pitch
	pitch1manual(lowVolIndex)=0;
end

% ====== Pitch after volume thresholding
pitch2=pitch1; pitch2(lowVolIndex)=0;
% ====== Pitch after smoothing
pitch3=smoothPitch(pitch2);

if plotOpt
	% ====== Plot wave form
	frameTime=(1:frameNum)*(PP.frameSize-PP.overlap)/PP.fs;
	plotNum=5;
	subplot(plotNum,1,1);
	tempH=plot((1:length(y))/PP.fs, y); set(tempH, 'tag', 'wave');
	if exist('waveFile'), title(['Wave file = "', waveFile, '"']); end
	axis([-inf inf -2^8/2+128 2^8/2-1+128]); grid on
	set(gca, 'tag', 'waveAxis');
	% ====== Plot volume
	subplot(plotNum,1,2);
	plot(frameTime, volume, 'o-');
	title('Sum of abs. magnitude');
	line([min(frameTime), max(frameTime)], PP.volThreshold*[1 1], 'color', 'r');
	set(gca, 'xlim', [-inf inf], 'tag', 'volumeAxis'); grid on
	% ====== Plot 電腦算的 pitch & 手動標示的 pitch
	subplot(plotNum,1,3);
	temp=pitch1; temp(temp==0)=nan;
	tempH=plot(frameTime, temp, 'o-', 'color', 'g'); set(tempH, 'erase', 'xor');	% 電腦算的 pitch
	temp=pitch1manual; temp(temp==0)=nan;
	line(frameTime, temp, 'color', 'k', 'marker', '*', 'erase', 'xor', 'tag', 'pitch1');	% 手動標示的 pitch
	title('Raw pitch: pitch1');
	axis tight; grid on
	set(gca, 'tag', 'pitch1Axis');
	
	% ====== Plot pitch after volume thresholding
	subplot(plotNum,1,4);
	temp=pitch2;
	temp(temp==0)=nan;
	pitch2H=plot(frameTime, temp, 'o-'); set(pitch2H, 'tag', 'pitch2', 'erase', 'xor', 'color', 'k');
	title('After volume thresholding: pitch2');
	axis tight; grid on
	set(gca, 'tag', 'pitch2Axis');
	set(gcf, 'name', [mfilename, '(using "', PP.frame2pitchFcn, '")']);
	% ====== Plot pitch after smoothing
	subplot(plotNum,1,5);
	temp=pitch3;	
	temp(temp==0)=nan;
	pitch3H=plot(frameTime, temp, 'o-'); set(pitch3H, 'tag', 'pitch3', 'erase', 'xor', 'color', 'k');
	title('After smoothing: pitch3');
	axis tight; grid on
	set(gca, 'tag', 'pitch3Axis');
end

% ====== self demo
function selfdemo
waveFile='waveData/test.wav';
plotOpt=1;
PP=setParam;
PP.frame2pitchFcn='frame2pitchSimple';
warning off MATLAB:divideByZero
feval(mfilename, waveFile, plotOpt, PP);