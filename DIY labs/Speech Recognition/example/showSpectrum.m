wavefile='清華大學資訊系.wav';
[y, fs, nbits] = wavread(wavefile);
y=y*(2^nbits/2);

subplot(3,1,1);
plot((1:length(y))/fs, y); axis tight
frameSize=256;

% 靜音
index1=500;
index2=index1+frameSize-1;
frame=y(index1:index2);
subplot(3,1,1);
line(index1*[1 1]/fs, 128*[-1 1], 'color', 'r');
line(index2*[1 1]/fs, 128*[-1 1], 'color', 'r');
subplot(3,3,4);
plot(frame); axis tight
subplot(3,3,7);
Y=fft(frame.*hamming(frameSize));
spectrum=log(abs(Y(1:frameSize/2+1)));
plot(spectrum); axis tight

% 氣音
index1=3072;
index2=index1+frameSize-1;
frame=y(index1:index2);
subplot(3,1,1);
line(index1*[1 1]/fs, 128*[-1 1], 'color', 'r');
line(index2*[1 1]/fs, 128*[-1 1], 'color', 'r');
subplot(3,3,5);
plot(frame); axis tight
subplot(3,3,8);
Y=fft(frame.*hamming(frameSize));
spectrum=log(abs(Y(1:frameSize/2+1)));
plot(spectrum); axis tight

% 有聲音
index1=20304;
index2=index1+frameSize-1;
frame=y(index1:index2);
subplot(3,1,1);
line(index1*[1 1]/fs, 128*[-1 1], 'color', 'r');
line(index2*[1 1]/fs, 128*[-1 1], 'color', 'r');
subplot(3,3,6);
plot(frame); axis tight
subplot(3,3,9);
Y=fft(frame.*hamming(frameSize));
spectrum=log(abs(Y(1:frameSize/2+1)));
plot(spectrum); axis tight