function [y, fs, nbits]=waveFileRead(waveFile)
% waveFileRead Read a wave file and convert it to 8-KHz sample rate and 8-bit resolution of unsigned integers between 0 and 255.

[y, fs, nbits]=wavread(waveFile);
y=y*(2^nbits/2)+2^nbits/2;		% 轉換成 unsigned integer (between 0 and 2^nbits-1)
if fs~=8000,
	fs2=8000;
	fprintf('Down sample of %s from %g to %g...\n', waveFile, fs, fs2);
	y=floor(resample(y, fs, fs2));	% Down sample to 8KHz
	fs=fs2;
end
if nbits==16,					% 轉換成 8-bit resolution
	fprintf('Reduce resolution of %s from 16-bit to 8-bit...\n', waveFile);
	y=floor((y+2^7)/2^8);
end