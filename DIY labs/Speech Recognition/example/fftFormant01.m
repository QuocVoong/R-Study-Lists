% This example demos the effect of FFT for purely periodic signals
[y, fs]=wavread('welcome.wav');
signal=y(2047+15:2126+15);		% A full fundamental period
zeros=0*signal;
signal=[signal; zeros; zeros; zeros; zeros; zeros];
%signal=y(2047:2047+512-1);
%signal=signal.*hamming(length(signal));
[mag, phase, freq, powerDb]=fftOneSide(signal, fs, 1);
lMaxIndex=find(localMax(mag));
subplot(3,1,2);
line(freq(lMaxIndex), powerDb(lMaxIndex), 'color', 'r', 'marker', 'o', 'linestyle', 'none');
fprintf('F1 = %f Hz\n', freq(lMaxIndex(1)));
fprintf('F2 = %f Hz\n', freq(lMaxIndex(2)));
fprintf('F3 = %f Hz\n', freq(lMaxIndex(3)));