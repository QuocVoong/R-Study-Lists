[signal, fs, nbits]=wavread('七.wav');
time=(1:length(signal))/fs;
subplot(211); plot(time, signal);
xlabel('時間（秒）'); ylabel('振幅');
title('發音「七」的波形');
set(gca, 'xlim', [min(time), max(time)]);
axisLimit=axis;

frameSize=1024;
start1=0.2*fs;
start2=0.9*fs;
index1=start1:start1+frameSize-1; time1=index1/fs;
index2=start2:start2+frameSize-1; time2=index2/fs;
line(time1(1)*[1 1], axisLimit(3:4), 'color', 'r', 'linewidth', 2);
line(time1(end)*[1 1], axisLimit(3:4), 'color', 'r', 'linewidth', 2);
line(time2(1)*[1 1], axisLimit(3:4), 'color', 'm', 'linewidth', 2);
line(time2(end)*[1 1], axisLimit(3:4), 'color', 'm', 'linewidth', 2);

consonant=signal(index1);
vowel=signal(index2);
subplot(223); plot(time1, consonant); axis([min(time1), max(time1), axisLimit(3:4)]);
subplot(224); plot(time2, vowel); axis([min(time2), max(time2), axisLimit(3:4)]);

subplot(211); loc1=get(gca, 'position');
subplot(223); loc2=get(gca, 'position');
subplot(224); loc3=get(gca, 'position');
% ===== arrow 1
x=[loc1(1)+(index1(1)-1)/(length(signal)-1)*loc1(3), loc2(1)];
y=[loc1(2), loc2(2)+loc2(4)];
ah=annotation('arrow', x, y, 'color', 'r', 'linewidth', 2);
% ====== arrow 2
x=[loc1(1)+(index1(end)-1)/(length(signal)-1)*loc1(3), loc2(1)+loc2(3)];
y=[loc1(2), loc2(2)+loc2(4)];
ah=annotation('arrow', x, y, 'color', 'r', 'linewidth', 2);
% ===== arrow 3
x=[loc1(1)+(index2(1)-1)/(length(signal)-1)*loc1(3), loc3(1)];
y=[loc1(2), loc3(2)+loc3(4)];
ah=annotation('arrow', x, y, 'color', 'm', 'linewidth', 2);
% ====== arrow 4
x=[loc1(1)+(index2(end)-1)/(length(signal)-1)*loc1(3), loc3(1)+loc3(3)];
y=[loc1(2), loc3(2)+loc3(4)];
ah=annotation('arrow', x, y, 'color', 'm', 'linewidth', 2);
