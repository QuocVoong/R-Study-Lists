close all

waveFile='小星星_不詳_0.wav';
[y, fs]=wavread(waveFile);

n=512;
t=(1:n)';
startIndex=30418;
endIndex=startIndex+n-1;

original=y(startIndex:endIndex);
windowed=original.*hamming(n);

Y1=abs(fft(original));
Y2=abs(fft(windowed));

range=(0:n/2)+1;
figure;
subplot(3,2,1); plot(original); grid on; axis([-inf inf -1 1]); title('Original signal');
subplot(3,2,2); plot(windowed); grid on; axis([-inf inf -1 1]); title('Windowed signal');
subplot(3,2,3); plot(Y1(range)); grid on; title('Energy spectrum (linear scale)');
subplot(3,2,4); plot(Y2(range)); grid on; title('Energy spectrum (linear scale)');
subplot(3,2,5); plot(20*log10(Y1(range))); grid on; axis([-inf inf -40 50]); title('Energy spectrum (log scale)');
subplot(3,2,6); plot(20*log10(Y2(range))); grid on; axis([-inf inf -40 50]); title('Energy spectrum (log scale)');