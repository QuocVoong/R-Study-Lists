waveFile = 'soo.wav';
[y, fs, nbits]=wavread(waveFile);
startIndex=15000;
frameSize=256;
endIndex=startIndex+frameSize-1;
frame=y(startIndex:endIndex);
order=20;
[frame2, error, coef]=sift(frame, order);	% Simple inverse filtering tracking
maxShift=frameSize;
method=1;
acf0=frame2acf(frame, maxShift, method);
acf1=frame2acf(error, maxShift, method);

subplot(3,1,1)
plot(1:frameSize, [frame, frame2]);
legend('Original Signal', 'LPC estimate');
title('Original signal vs. LPC estimate');
subplot(3,1,2);
plot(1:frameSize, error);
grid on
xlabel(['Residual signal when order = ', int2str(order)]);
subplot(3,1,3);
plot(1:frameSize, [acf0/max(acf0), acf1/max(acf1)]);
grid on
xlabel('Normalized ACF curves');
legend('Normalized ACF on original frame', 'Normalized ACF on residual signal');