waveFile='whatMovies.wav';
[x, fs, nbits]=wavread(waveFile);
% Filter parameters
a = [1];
b = [1, 1, 1, 1, 1]/5;
y = filter(b, a, x);
% Plot the result
time = (1:length(x))/fs;
subplot(2,1,1);
plot(time, x); title('Original signal x[n]');
subplot(2,1,2);
plot(time, y); title('Output signal y[n]');
wavwrite(y, fs, nbits, 'lpf01.wav');	% Save the output signal