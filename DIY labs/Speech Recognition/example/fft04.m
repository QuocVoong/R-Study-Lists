% This example demonstrates the DFT of a real-world audio signal (顯示一個語音音框的單邊頻譜)
[y, fs]=wavread('welcome.wav');
signal=y(2047:2047+237-1);
[mag, phase, freq]=fftOneSide(signal, fs, 1);