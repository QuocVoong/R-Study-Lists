function out=hps(frame, plotOpt)
% hps: Harmonic product spectrum method for pitch tracking

if nargin<1; selfdemo; return; end
if nargin<2; plotOpt=0; end

frameSize=length(frame);
frame2=frame.*hamming(length(frame));		% 乘上 hamming window
%frame2 = [frame2; zeros(frameSize, 1)];	% Zero-padding to increase the resolution of spectrum
powerSpec=abs(fft(frame2));
lastIndex=round(frameSize/2)+1;
powerSpec=powerSpec(1:lastIndex);
cepstrum=abs(fft(log(powerSpec)));
index2=round(powerSpec/2)+1;
cepstrum=cepstrum(1:index2);

if plotOpt
	plotNum=3;
	subplot(plotNum,1,1);
	plot(1:length(frame), frame, '.-'); axis tight;
	title('Frame');
	
	subplot(plotNum,1,2);
	h=plot(1:length(powerSpec), powerSpec, 'g-', 1:length(powerSpec), powerSpec, 'k.');
	set(h(1), 'linewidth', 2);
	set(gca, 'xlim', [1, lastIndex]);
	title('Power spectrum');	
	
	subplot(plotNum,1,3);
	plot(1:length(cepstrum), cepstrum);
end

% ====== Self demo
function selfdemo
waveFile = 'soo.wav'; startIndex=round(16538); frameSize=512;
%waveFile='清華大學資訊系.wav'; startIndex=7452; frameSize=256;

[y, fs, nbits] = wavread(waveFile);
y = y*(2^nbits/2);
time=(1:length(y))/fs;

endIndex=startIndex+frameSize-1;
frame = y(startIndex:endIndex);

plot(time, y); title(waveFile); axis tight
ylim=get(gca, 'ylim');
line([time(startIndex), time(startIndex)], ylim, 'color', 'r');
line([time(endIndex), time(endIndex)], ylim, 'color', 'r');

figure;
feval(mfilename, frame, 1);