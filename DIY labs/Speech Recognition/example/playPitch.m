function y=playPitch(pitch, timeUnit, plotOpt)

if nargin<1, selfdemo; return; end
if nargin<2, timeUnit=256/8000; end
if nargin<3, plotOpt=0; end
pitch=pitch(:);
freq=440*2.^((pitch-69)/12);
%freq=2*freq;		% Double the frequency to make it more pleasant to hear!
freq(pitch==0)=0;
fs=8000;
point=round(fs*timeUnit);
time=(0:point-1)/fs;
slope=1-(0:point-1)/(point-1);
y=[];
for i=1:length(pitch)
	this=sin(2*pi*freq(i)*time).*slope;
	y=[y, this];
end
wavplay(y, fs, 'sync');

if plotOpt
	plot((1:length(y))/fs, y, '.-');
end