waveFile='soo.wav';
[y, fs, nbits]=wavread(waveFile);
frameSize=256; overlap=0;
framedY=buffer(y, frameSize, overlap);
frame=framedY(:, 290);
subplot(4,1,1);
plot(frame, '.-'); axis tight
title('Input frame');
subplot(4,1,2);
method=1; out=frame2acfOverAmdf(frame, frameSize, method);
plot(out, '.-'); title('ACF/AMDF, method=1'); axis tight
subplot(4,1,3);
method=2; out=frame2acfOverAmdf(frame, frameSize, method);
plot(out, '.-'); title('ACF/AMDF, method=2'); axis tight
subplot(4,1,4);
method=3; out=frame2acfOverAmdf(frame, frameSize/2, method);
plot(out, '.-'); title('ACF/AMDF, method=3'); axis tight