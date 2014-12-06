% Example 3: Add zero padding

N = 64;
T = 1;
f = 0.25 + 0.5/N;   % Move frequency off-center by half a bin
n = 0:N-1;

% Example 3: Add zero padding
zpf = 8;                   % zero-padding factor
x = [cos(2*pi*n*f*T),zeros(1,(zpf-1)*N)];  % zero-padded FFT input data
X = fft(x);                 % Interpolated spectrum

subplot(3,1,1);
ni = [0:.1:N-1];      % Interpolated time axis
plot(ni, cos(2*pi*ni*f*T));
line(0:zpf*N-1, x, 'color', 'b', 'marker', 'o', 'linestyle', 'none');
title('Zero-Padded Sampled Sinusoid');
xlabel('Time (samples)'); ylabel('Amplitude');
axis tight;

% Plot spectral magnitude
magX = abs(X);
nfft = zpf*N;
fni = [0:1.0/nfft:1-1.0/nfft];   % Normalized frequency axis
subplot(3,1,2);
plot(fni,magX,'-'); grid; % With interpolation, we can use solid lines '-'
title('Interpolated Spectral Magnitude'); 
xlabel('Normalized Frequency (cycles per sample))'); 
ylabel('Magnitude (Linear)');
text(-.11,40,'b)');

% Same thing on a dB scale
spec = 20*log10(magX);  % Spectral magnitude in dB
spec = max(spec,-60*ones(1,length(spec))); % clip to -60 dB
subplot(3,1,3);
plot(fni, spec);
% title('Interpolated Spectral Magnitude (dB)'); 
xlabel('Normalized Frequency (cycles per sample))'); 
ylabel('Magnitude (dB)');

