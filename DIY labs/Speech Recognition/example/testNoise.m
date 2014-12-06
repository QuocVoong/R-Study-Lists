waveFile='清華大學資訊系.wav';
[y, fs]=wavreadc(waveFile);

frameSize=256;
overlap=0;
framedY=buffer2(y, frameSize, overlap);
logEnergy=frame2logEnergy(framedY); 
entropy=frame2entropy(framedY, fs);


subplot(3,1,1)
plot(logEnergy);
subplot(3,1,2)
plot(entropy);
subplot(3,1,3)
plot(1./entropy);



for i=1:10,
	noise=i/100*randn(length(y), 1);
	framedY=buffer2(noise, frameSize, overlap);
	logEnergy=frame2logEnergy(framedY);
	fprintf('i=%d, ave. log. energy=%g\n', i, mean(logEnergy));
	
end
