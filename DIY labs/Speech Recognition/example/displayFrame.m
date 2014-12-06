waveFile='csNthu.wav';
[signal, fs, nbits]=wavread(waveFile);
index1=11050;
frameSize=512;
index2=index1+frameSize-1;
frame=signal(index1:index2);

subplot(2,1,1); plot(signal); grid on
xlabel('Sample index'); ylabel('Amplitude'); title(waveFile);
axis([1, length(signal), -1 1]);
line(index1*[1 1], [-1 1], 'color', 'r', 'linewidth', 2);
line(index2*[1 1], [-1 1], 'color', 'r', 'linewidth', 2);
subplot(2,1,2); plot(frame, '.-'); grid on
xlabel('Frame index'); ylabel('Amplitude');
point=[83, 485];
line(point, frame(point), 'marker', 'o', 'color', 'red');
axis([1, length(frame), -1 1]);

periodCount=3;
fp=((point(2)-point(1))/periodCount)/fs;	% fundamental period
ff=fs/((point(2)-point(1))/periodCount);	% fundamental frequency
pitch=69+12*log2(ff/440);
fprintf('Fundamental period = %g second\n', fp);
fprintf('Fundamental frequency = %g Hertz\n', ff);
fprintf('Pitch = %g semitone\n', pitch);

subplot(211); loc1=get(gca, 'position');
subplot(212); loc2=get(gca, 'position');
% ===== arrow 1
x=[loc1(1)+(index1(1)-1)/(length(signal)-1)*loc1(3), loc2(1)];
y=[loc1(2), loc2(2)+loc2(4)];
ah=annotation('arrow', x, y, 'color', 'r', 'linewidth', 2);
% ====== arrow 2
x=[loc1(1)+(index2-1)/(length(signal)-1)*loc1(3), loc2(1)+loc2(3)];
y=[loc1(2), loc2(2)+loc2(4)];
ah=annotation('arrow', x, y, 'color', 'r', 'linewidth', 2);

h1=text(point(1), frame(point(1)), ['  \leftarrow index=', int2str(point(1))], 'rotation', 90);
h2=text(point(2), frame(point(2)), ['  \leftarrow index=', int2str(point(2))], 'rotation', 90);
