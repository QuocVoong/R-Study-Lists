% Example 5: Practical spectrum analysis of a sinusoidal signal

% Analysis parameters:
M = 31;         % Window length (we'll use a "Hanning window")
N = 64;         % FFT length (zero padding around a factor of 2)

% Signal parameters:
wxT = 2*pi/4;   % Sinusoid frequency in rad/sample (1/4 sampling rate)
A = 1;          % Sinusoid amplitude
phix = 0;       % Sinusoid phase

% Compute the signal x:
n = [0:N-1];    % time indices for sinusoid and FFT
x = real(A*exp(j*wxT*n+phix)); % the complex sinusoid itself: [1,j,-1,-j,1,j,...]

% Compute Hanning window:
nm = [0:M-1];   % time indices for window computation
w = (1/M) * (cos((pi/M)*(nm-(M-1)/2))).^2;  % Hanning window = "raised cosine"
% (FIXME: normalizing constant above should be 2/M)

wzp = [w,zeros(1,N-M)]; % zero-pad out to the length of x
xw = x .* wzp;          % apply the window w to the signal x

% Display real part of windowed signal and the Hanning window:
plot(n,wzp,'-'); hold on;
plot(n,real(xw),'*'); 
title('Hanning Window and Windowed, Zero-Padded, Sinusoid (Real Part)'); 
xlabel('Time (samples)'); ylabel('Amplitude'); hold off;

Xw = fft(xw);              % FFT of windowed data
fn = [0:1.0/N:1-1.0/N];    % Normalized frequency axis
spec = 20*log10(abs(Xw));  % Spectral magnitude in dB
% Since the zeros go to minus infinity, clip at -100 dB:
spec = max(spec,-150);
phs = angle(Xw);           % Spectral phase in radians
phsu = unwrap(phs);        % Unwrapped spectral phase (using matlab function)

Nzp = 16;                   % Zero-padding factor
Nfft = N*Nzp;               % Increased FFT size
xwi = [xw,zeros(1,Nfft-N)]; % New zero-padded FFT buffer
Xwi = fft(xwi);             % Take the FFT
fni = [0:1.0/Nfft:1.0-1.0/Nfft]; % Normalized frequency axis
speci = 20*log10(abs(Xwi));      % Interpolated spectral magnitude in dB
speci = max(speci,-100); % clip at -100 dB
phsi = angle(Xwi);          % Phase
phsiu = unwrap(phsi);       % Unwrapped phase

% Plot spectral magnitude
figure
subplot(3,1,1); plot(fn, abs(Xw),'.'); line(fni, abs(Xwi)); title('Spectral Magnitude'); ylabel('Amplitude (Linear)');
subplot(3,1,2); plot(fn, phs, '.'); line(fni, phsi); title('Phase');
subplot(3,1,3); plot(fn, phsu, '.'); line(fni, phsiu); title('Unwrapped phase');
xlabel('Normalized Frequency (cycles per sample))'); 

% Same thing on a dB scale
figure
subplot(3,1,1); plot(fn, spec,'.'); line(fni, speci); title('Spectral Magnitude (dB)'); ylabel('Magnitude (dB)');
subplot(3,1,2); plot(fn, phs, '.'); line(fni, phsi);  title('Phase');
subplot(3,1,3); plot(fn, phsu, '.'); line(fni, phsiu); title('Unwrapped phase');
xlabel('Normalized Frequency (cycles per sample))'); 