% Use the Blackman window on the sinusoid data
N=64;
zpf=8;
xw = [w .* cos(2*pi*n*f*T),zeros(1,(zpf-1)*N)]; % windowed, zero-padded data
X = fft(xw);                                    % Smoothed, interpolated spectrum

% Plot time data
subplot(2,1,1);
plot(xw);        
title('Windowed, Zero-Padded, Sampled Sinusoid');
xlabel('Time (samples)'); ylabel('Amplitude');
text(-50,1,'a)')

% Plot spectral magnitude in the best way
spec = 10*log10(conj(X).*X);  % Spectral magnitude in dB
spec = max(spec,-60*ones(1,nfft)); % clip to -60 dB
subplot(2,1,2);
plot(fninf,fftshift(spec),'-'); axis([-0.5,0.5,-60,40]); grid;
title('Smoothed, Interpolated, Spectral Magnitude (dB)'); 
xlabel('Normalized Frequency (cycles per sample))'); 
ylabel('Magnitude (dB)');