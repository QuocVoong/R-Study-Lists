waveFile='whatFood.wav';
[y, fs, nbits]=wavread(waveFile);
a=0.95;
y2 = filter([1, -a], 1, y);
time=(1:length(y))/fs;
wavwrite(y2, fs, nbits, 'whatFood_preEmphasis.wav'); 

subplot(2,1,1);
plot(time, y);
title('Original wave: s(n)');
subplot(2,1,2);
plot(time, y2);
title(sprintf('After pre-emphasis: s_2(n)=s(n)-a*s(n-1), a=%f', a));

subplot(2,1,1);
set(gca, 'unit', 'pixel');
axisPos=get(gca, 'position');
uicontrol('string', 'Play', 'position', [axisPos(1:2), 60, 20], 'callback', 'sound(y, fs)');
subplot(2,1,2);
set(gca, 'unit', 'pixel');
axisPos=get(gca, 'position');
uicontrol('string', 'Play', 'position', [axisPos(1:2), 60, 20], 'callback', 'sound(y2, fs)');
