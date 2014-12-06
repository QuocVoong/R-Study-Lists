fileName='welcome.wav';
[y, fs, nbits]=wavread(fileName);
y0=y*(2^nbits/2)+(2^nbits/2);		% y0 is the original values stored in the wav file (y0 是原先儲存在音訊檔案中的值)
difference=sum(abs(y0-round(y0)))