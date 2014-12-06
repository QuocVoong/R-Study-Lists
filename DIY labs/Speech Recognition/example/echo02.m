waveFile='whatMovies.wav';
[x, fs, nbits]=wavread(waveFile);
% Filter parameters
delay=0.2;
gain=0.8;
a = [1 zeros(1, round(delay*fs)), -gain];
b = [1];
y = filter(b, a, x);
% Plot the result
time = (1:length(x))/fs;
subplot(2,1,1);
plot(time, x); title('Original signal x[n]');
subplot(2,1,2);
plot(time, y); title('Filter output y[n]');
wavwrite(y, fs, nbits, 'echo02.wav');	% Save the output signal