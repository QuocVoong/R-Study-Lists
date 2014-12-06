% Same as fft02.m but use one-side DFT instead (同 fft02.m，但以單邊頻譜來顯示)
N = 256;					% length of vector (點數)
fs = 8000;					% sample rate (取樣頻率)
freqStep = fs/N;				% freq resolution in spectrum (頻域的頻率的解析度)
f = 10.5*freqStep;				% freq of the sinusoid (正弦波的頻率，不是 freqStep 的整數倍)
time = (0:N-1)/fs;				% time resolution in time-domain (時域的時間刻度)
signal = cos(2*pi*f*time);			% signal to analyze
[mag, phase, freq]=fftOneSide(signal, fs, 1);	% Compute and plot one-side DFT