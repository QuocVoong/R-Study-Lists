% 此範例展示一個簡單正弦波的傅立葉轉換，以雙邊頻譜來顯示
% 此正弦波的頻率恰巧是 freqStep 的非整數倍，所以雙邊頻譜會「散開」(Smearing)

k = 10.5;			% 非整數倍 
N = 256;			% 點數
fs = 8000;			% 取樣頻率
freqStep = fs/N;		% 頻域的頻率的解析度
f = k*freqStep;			% 正弦波的頻率
freq = freqStep*(-N/2:N/2-1);	% 頻域的頻率刻度
time = (0:N-1)/fs;		% 時域的時間刻度
y = cos(2*pi*f*time);		% Signal to analyze
Y = fft(y);			% Spectrum
Y = fftshift(Y);

% Plot time data
subplot(3,1,1);
time2 = (0:0.1:N-1)/fs;		% Interpolated time axis
plot(time2, cos(2*pi*f*time2));
line(time, y, 'color', 'r', 'marker', '.', 'linestyle', 'none');
title('Sinusoidal signals');
xlabel('Time (seconds)'); ylabel('Amplitude');
axis tight

% Plot spectral magnitude
magY = abs(Y);
subplot(3,1,2);
plot(freq, magY, '.-b'); grid on
xlabel('Frequency)'); 
ylabel('Magnitude (Linear)');

% Plot phase
phaseY = unwrap(angle(Y));
subplot(3,1,3);
plot(freq, phaseY, '.-b'); grid on
xlabel('Frequency)'); 
ylabel('Phase (Radian)');
