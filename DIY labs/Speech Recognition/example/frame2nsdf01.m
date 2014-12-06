waveFile='sunday.wav';
[y, fs, nbits]=wavread(waveFile);
index1=9000;
frameSize=512;
index2=index1+frameSize-1;
frame=y(index1:index2);
maxShift=length(frame);
method=1;
acf=frame2nsdf(frame, maxShift, method);

subplot(3,1,1); plot(y);
line(index1*[1 1], [-1 1], 'color', 'r');
line(index2*[1 1], [-1 1], 'color', 'r');
subplot(3,1,2); plot(frame);
subplot(3,1,3); plot(acf);