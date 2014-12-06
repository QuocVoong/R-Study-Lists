waveFile='清華大學資訊系.wav';
waveFile='flanger.wav';
fid=fopen(waveFile, 'r');

out=fread(fid, 4, 'uchar');
fprintf('0~3 ===> %s\n', char(out'));

out=fread(fid, 1, 'uint32');
fprintf('4~7 ===> %d\n', out);

out=fread(fid, 4, 'uchar');
fprintf('8~11 ===> %s\n', char(out'));

out=fread(fid, 4, 'uchar');
fprintf('12~15 ===> %s\n', char(out'));

out=fread(fid, 1, 'uint32');
fprintf('16~19 ===> %d\n', out);

out=fread(fid, 1, 'uint16');
fprintf('20~21 ===> %d (format tag)\n', out);

out=fread(fid, 1, 'uint16');
fprintf('22~23 ===> %d (channel)\n', out);

fs=fread(fid, 1, 'uint32');
fprintf('24~27 ===> %d (Hz)\n', fs);

out=fread(fid, 1, 'uint32');
fprintf('28~31 ===> %d (bytes/second)\n', out);

out=fread(fid, 1, 'uint8');
fprintf('32~33 ===> %d (bytes/time instant)\n', out);

out=fread(fid, 1, 'uint8');
fprintf('34~34 ===> %d (junk)\n', out);

nbits=fread(fid, 1, 'uint8');
fprintf('35~35 ===> %d (bit resolution)\n', nbits);

out=fread(fid, 1, 'uint8');
fprintf('36~36 ===> %d (junk)\n', out);

out1=fread(fid, 4, 'uchar');
fprintf('37~40 ===> %s\n', char(out1'));

out=fread(fid, 1, 'uint32');
fprintf('41~44 ===> %d\n', out);

if nbits==8
	data=fread(fid, inf, 'uint8');
	plot(data);
	sound((data-128)/128, fs);
end

% buggy!
if nbits==16
	data=fread(fid, inf, 'int16');
	y=reshape(data, 2, length(data)/2);
end



fclose(fid);