fs=8000;		% Sampling rate
filterOrder=5;		% Order of filter

% ====== low-pass filter
cutOffFreq=1000;
[b, a]=butter(filterOrder, cutOffFreq/(fs/2), 'low');
[h, w]=freqz(b, a);
subplot(2,2,1);
plot(w/pi*fs/2, abs(h), '.-');
xlabel('Freq (Hz)'); title('Freq. response of a low-pass filter'); grid on

% ====== high-pass filter
cutOffFreq=2000;
[b, a]=butter(filterOrder, cutOffFreq/(fs/2), 'high');
[h, w]=freqz(b, a);
subplot(2,2,2);
plot(w/pi*fs/2, abs(h), '.-');
xlabel('Freq (Hz)'); title('Freq. response of a high-pass filter'); grid on

% ====== band-pass filter
passBand=[1000, 2000];
[b, a]=butter(filterOrder, passBand/(fs/2));
[h, w]=freqz(b, a);
subplot(2,2,3);
plot(w/pi*fs/2, abs(h), '.-');
xlabel('Freq (Hz)'); title('Freq. response of a band-pass filter'); grid on

% ====== band-stop filter
stopBand=[1000, 2000];
[b, a]=butter(filterOrder, stopBand/(fs/2), 'stop');
[h, w]=freqz(b, a);
subplot(2,2,4);
plot(w/pi*fs/2, abs(h), '.-');
xlabel('Freq (Hz)'); title('Freq. response of a band-stop filter'); grid on