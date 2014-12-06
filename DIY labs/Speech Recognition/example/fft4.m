% Add a "Blackman window"
% w = blackman(M); % if you have the signal processing toolbox
M=64;
w = .42-.5*cos(2*pi*(0:M-1)/(M-1))+.08*cos(4*pi*(0:M-1)/(M-1));
figure(5);
subplot(3,1,1); plot(w,'*'); title('The Blackman Window');
xlabel('Time (samples)'); ylabel('Amplitude');
text(-8,1,'a)'); 

% Also show the window transform:
xw = [w,zeros(1,(zpf-1)*M)]; % zero-padded window (col vector)
Xw = fft(xw);                 % Blackman window transform
spec = 20*log10(abs(Xw));     % Spectral magnitude in dB
spec = spec - max(spec);      % Usually we normalize to 0 db max
spec = max(spec,-100*ones(1,nfft)); % clip to -100 dB
subplot(3,1,2); plot(fni,spec,'-'); axis([0,1,-100,10]); grid;
xlabel('Normalized Frequency (cycles per sample))'); 
ylabel('Magnitude (dB)');
text(-.12,20,'b)'); 

% Replot interpreting upper bin numbers as negative frequencies:
nh = nfft/2;
specnf = [spec(nh+1:nfft),spec(1:nh)];  % see also Matlab's fftshift()
fninf = fni - 0.5;
subplot(3,1,3);
plot(fninf,specnf,'-'); axis([-0.5,0.5,-100,10]); grid;
xlabel('Normalized Frequency (cycles per sample))'); 
ylabel('Magnitude (dB)');