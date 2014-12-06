function out = endPointDetect02(y, fs, plotOpt, epdPrm)
% ENDPOINT End point detection
%	Usage: out = endPointDetection(y, fs, plotOpt, epdPrm)

if nargin==0, selfdemo; return; end
if nargin<4,
	epdPrm.frameSize = 256;
	epdPrm.overlap = 86;
	epdPrm.deltaEnergyLevel1 = -20;
	epdPrm.deltaEnergyLevel2 = -10;
	epdPrm.zcrRatio = 0.2;
end
if nargin<3, plotOpt=0; end
if nargin<2, fs=8000; end

frameSize=epdPrm.frameSize;
overlap=epdPrm.overlap;
deltaEnergyLevel1=epdPrm.deltaEnergyLevel1;
deltaEnergyLevel2=epdPrm.deltaEnergyLevel2;
zcrRatio=epdPrm.zcrRatio;

% ====== Zero adjusted
y = y-mean(y);
%wavplay(y, fs, 'sync');

% ====== Take frames
framedY  = buffer2(y, frameSize, overlap);
frameNum = size(framedY, 2);	% Number of frames

% ====== Compute log energy
energy = frame2logEnergy(framedY);
time = ((0:frameNum-1)*(frameSize-overlap)+0.5*frameSize)/fs;
energyLevel1 = max(energy)+deltaEnergyLevel1;
energyLevel2 = max(energy)+deltaEnergyLevel2;

% ====== Compute zero crossing rate
zcr = zcrate(framedY-0.03);

% ====== Find initial end points according energy level2 (upper level)
voicedIndex = find(energy>=energyLevel2);
zcrThreshold = max(zcr)*zcrRatio;
sound = [];
k = 1;
sound(k).begin = voicedIndex(1);
for i=2:length(voicedIndex)-1,
	if voicedIndex(i+1)-voicedIndex(i)>1,
		sound(k).end = voicedIndex(i);
		sound(k+1).begin = voicedIndex(i+1);
		k = k+1;
	end
end
sound(k).end = voicedIndex(end);

% ====== Delete short sound clips
index = [];
for i=1:length(sound),
	if (sound(i).end-sound(i).begin)<3
		index = [index, i];
	end
end
%index
%sound(i).end
%sound(i).begin
sound(index) = [];

%minIndex = localmax(-energy);	% Find index of local minima
% ====== Expand end points to energy level1 (lower level)
for i=1:length(sound),
	head = sound(i).begin;
%	while (head-1)>=1 & energy(head-1)>energyLevel1 & ~minIndex(head-1),
	while (head-1)>=1 & energy(head-1)>=energyLevel1,
		head=head-1;
	end
	sound(i).begin = head;
	tail = sound(i).end;
%	while (tail+1)<=length(energy) & energy(tail+1)>energyLevel1 & ~minIndex(tail+1),
	while (tail+1)<=length(energy) & energy(tail+1)>energyLevel1,
		tail=tail+1;
	end
	sound(i).end = tail;
end

% ====== Expand end points to include high zcr region
for i=1:length(sound),
	head = sound(i).begin;
	while (head-1)>=1 & zcr(head-1)>=zcrThreshold,
		head=head-1;
	end
	sound(i).begin = head;
end

% ====== Delete repeated sound segments
if length(sound) ~=0,
	index = [];
	for i=1:length(sound)-1,
		if sound(i).begin==sound(i+1).begin & sound(i).end==sound(i+1).end,
			index=[index, i];
		end
	end
	sound(index) = [];
end;

% ====== Transform sample-point-based index
if length(sound) ~=0,
	for i=1:length(sound),
		out(i).begin = (sound(i).begin-1)*(frameSize-overlap)+1;
		out(i).end   = (sound(i).end)*(frameSize-overlap)+overlap;
	end
else
	out = [];
end;

if plotOpt
	subplot(3,1,1);
	plot((1:length(y))/fs, y);
	axis([-inf inf -1 1]);
	ylabel('Amplitude');
	title('Wave form');

	subplot(3,1,2);
	plot(time, energy, '.-');
	line([min(time), max(time)], energyLevel1*[1 1], 'color', 'c');
	line([min(time), max(time)], energyLevel2*[1 1], 'color', 'c');
	axis tight
	ylabel('Log energy (dB)');
	title('Log energy');

	subplot(3,1,3);
	plot(time, zcr, '.-');
	line([min(time), max(time)], zcrThreshold*[1 1], 'color', 'c');
	axis([-inf inf 0 inf]);
	ylabel('ZCR');
	title('Zero crossing rate');

	% Plot end points
	subplot(3,1,1);
	yBound = [-1 1];
	for i=1:length(sound),
		line(sound(i).begin*(frameSize-overlap)/fs*[1,1], yBound, 'color', 'r');
		line(  sound(i).end*(frameSize-overlap)/fs*[1,1], yBound, 'color', 'g');
	end
	% Plot end points
	subplot(3,1,2);
	yBound = [min(energy) max(energy)];
	for i=1:length(sound),
		line(sound(i).begin*(frameSize-overlap)/fs*[1,1], yBound, 'color', 'r');
		line(  sound(i).end*(frameSize-overlap)/fs*[1,1], yBound, 'color', 'g');
	end
	
	% Plot end points
	subplot(3,1,3);
	yBound = [0 max(zcr)];
	for i=1:length(sound),
		line(sound(i).begin*(frameSize-overlap)/fs*[1,1], yBound, 'color', 'r');
		line(  sound(i).end*(frameSize-overlap)/fs*[1,1], yBound, 'color', 'g');
	end

	% Play the segmented sound
%	fprintf('%g sound clips are collected.\n', length(sound));
%	for i=1:length(sound),
%		head = sound(i).begin*(frameSize-overlap);
%		tail = min(length(y), sound(i).end*(frameSize-overlap));
%		thisY = y(head:tail);
%		fprintf('His return to hear the cutted sound %g:', i);
%		pause;
%		fprintf('\n');
%		wavplay(thisY, fs, 'sync');
%	end
%	fprintf('\n');
end

% ====== Self demo
function selfdemo
epdPrm.frameSize = 256;
epdPrm.overlap = 128;
epdPrm.deltaEnergyLevel1 = -20;
epdPrm.deltaEnergyLevel2 = -10;
epdPrm.zcrRatio = 0.1;
fs = 8000;
duration = 3;
plotOpt = 1;
%y = recsound('test.wav', duration, fs);
wavefile='清華大學資訊系.wav';
[y, fs, nbits] = wavread(wavefile);
%y=y*(2^nbits/2);
out = feval(mfilename, y, fs, plotOpt, epdPrm);