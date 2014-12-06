% This example demonstrates the one-side DFT of a sinusoidal function (此範例展示一個簡單正弦波的傅立葉轉換，以雙邊頻譜來顯示)
% Since the sinusoidal function has a frequency not a multiple of fs/N, the two-side DFT smears. (此正弦波的頻率不是 freqStep 的整數倍，所以雙邊頻譜會「散開」(Smearing))

N = 256;					% length of vector (點數)
fs = 8000;					% sample rate (取樣頻率)
freqStep = fs/N;				% freq resolution in spectrum (頻域的頻率的解析度)
f = 10.5*freqStep;				% freq of the sinusoid (正弦波的頻率，不是 freqStep 的整數倍)
time = (0:N-1)/fs;				% time resolution in time-domain (時域的時間刻度)
signal = cos(2*pi*f*time);			% signal to analyze
[mag, phase, freq]=fftTwoSide(signal, fs, 1);	% compute and plot the two-side DFT