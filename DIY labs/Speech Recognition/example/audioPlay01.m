waveFile='aeiou.wav';
wObj=waveFile2obj(waveFile);
time=(1:length(wObj.signal))/wObj.fs;
subplot(211);
plot(time, wObj.signal); axis([min(time), max(time), -1, 1]);
ylabel('Amplitude');
subplot(212);
frameSize=256;
overlap=frameSize/2;
[S,F,T]=spectrogram(wObj.signal, frameSize, overlap, 4*frameSize, wObj.fs);
imagesc(T, F, log(abs(S))); axis xy
xlabel('Time (sec)');
ylabel('Freq (Hz)');

% Find all axes and create all progressive bars
axesH=findobj(0, 'type', 'axes');
for i=1:length(axesH)
	set(gcf, 'currentAxes', axesH(i));
	axisLimit=axis(axesH(i));
	barH(i)=line(nan*[1 1], axisLimit(3:4), 'color', 'r', 'erase', 'xor', 'linewidth', 3);
end

p=audioplayer(wObj.signal, wObj.fs);
currTime=0;
timerPeriod=0.02;
set(p, 'TimerFcn', 'currTime=currTime+timerPeriod; set(barH, ''xdata'', currTime*[1 1]);', 'TimerPeriod', timerPeriod);
play(p);
