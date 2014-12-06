function acfVec=frame2acf(frame, plotOpt)

if nargin<1, selfdemo; return; end
if nargin<2, plotOpt=0; end

frame=frame-mean(frame);
for i = 1:length(frame)
	acfVec(i) = sum(frame(i:end).*frame(1:end-i+1));	% 平移 frame(1:end)，再求重疊部分的內積
%	acfVec(i) = mean(frame(i:end).*frame(1:end-i+1));	% 平移 frame(1:end)，再求重疊部分的內積，再求平均
end

if plotOpt
	subplot(2,1,1);
	plot(frame, '.-'); grid on
	set(gca, 'xlim', [-inf inf]);
	title('Frame');
	subplot(2,1,2);
	plot(acfVec, '.-'); grid on
	set(gca, 'xlim', [-inf inf]);
	title('acf vector');
end

% ====== Self demo
function selfdemo
waveFile='清華大學資訊系3.wav';
[y, fs, nbits]=waveFileRead(waveFile);
index1=7200;
frameSize=256;
index2=index1+frameSize-1;
frame=y(index1:index2);
plotOpt=1;
feval(mfilename, frame, plotOpt);