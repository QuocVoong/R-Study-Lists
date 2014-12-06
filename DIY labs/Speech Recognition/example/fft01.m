% This example demonstrates the two-side DFT of a sinusoidal function
% (此範例展示一個簡單正弦波的傅立葉轉換，以雙邊頻譜來顯示)
% Since the sinusoidal function has a frequency to be a multiple of fs/N, the two-side DFT have only two nonzero terms.
% (此正弦波的頻率恰巧是 freqStep 的整數倍，所以雙邊頻譜應該只有兩個非零點)

N = 256;			% length of vector (點數)
fs = 8000;			% sample rate (取樣頻率)
freqStep = fs/N;		% freq resolution in spectrum (頻域的頻率的解析度)
f = 10*freqStep;		% freq of the sinusoid (正弦波的頻率，恰是 freqStep 的整數倍)
time = (0:N-1)/fs;		% time resolution in time-domain (時域的時間刻度)
y = cos(2*pi*f*time);		% signal to analyze
Y = fft(y);			% spectrum
Y = fftshift(Y);		% put zero freq at the center (將頻率軸的零點置中)

% Plot time data
subplot(3,1,1);
plot(time, y, '.-');
title('Sinusoidal signals');
xlabel('Time (seconds)'); ylabel('Amplitude');
axis tight

% Plot spectral magnitude
freq = freqStep*(-N/2:N/2-1);	% freq resolution in spectrum (頻域的頻率的解析度)
subplot(3,1,2);
plot(freq, abs(Y), '.-b'); grid on
xlabel('Frequency)'); 
ylabel('Magnitude (Linear)');

% Plot phase
subplot(3,1,3);
plot(freq, angle(Y), '.-b'); grid on
xlabel('Frequency)'); 
ylabel('Phase (Radian)');