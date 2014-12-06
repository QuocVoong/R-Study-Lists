close all

n=512;
f=1/26.11;
t=(1:n)';

original=sin(2*pi*f*t)+0.2*randn(n,1);
windowed=original.*hamming(n);

Y1=abs(fft(original));
Y2=abs(fft(windowed));

range=(0:n/2)+1;
figure;
subplot(3,2,1); plot(original); grid on; axis([-inf inf -1 1]); title('Original signal');
subplot(3,2,2); plot(windowed); grid on; axis([-inf inf -1 1]); title('Windowed signal');
subplot(3,2,3); plot(Y1(range)); grid on; title('Energy spectrum (linear scale)');
subplot(3,2,4); plot(Y2(range)); grid on; title('Energy spectrum (linear scale)');
subplot(3,2,5); plot(20*log10(Y1(range))); grid on; axis([-inf inf -20 50]); title('Energy spectrum (log scale)');
subplot(3,2,6); plot(20*log10(Y2(range))); grid on; axis([-inf inf -20 50]); title('Energy spectrum (log scale)');