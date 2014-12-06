waveFile='waveData/火車快飛.wav';
%waveFile='waveData/soo.wav';
[y, fs, nbits]=waveFileRead(waveFile);

frameSize=256;
overlap=0;
framedY=buffer(y, frameSize, overlap);
frameNum=size(framedY, 2);

pitch=[];
volume=[];
for i=1:frameNum
	frame=framedY(:, i);
	frame=frame-mean(frame);
	acf=frame2acf(frame);
	acf(1:9)=0;			% 假設最高頻不超過1000Hz
	[maxValue, index]=max(acf);
	freq=fs/(index-1);
	pitch(i)=69+12*log2(freq/440);
	volume(i)=sum(abs(frame));
end

volumeTh=max(volume)*0.1;
index=find(volume<volumeTh);

figure
subplot(3,1,1);
plot(y);
subplot(3,1,2);
plot(volume);
line([1, frameNum], volumeTh*[1 1], 'color', 'r');
subplot(3,1,3);
pitch(index)=nan;
plot(pitch, '.-');
%playmid(pitch, frameSize/fs);
playPitch(pitch, frameSize/fs);