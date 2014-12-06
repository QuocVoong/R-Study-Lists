function threshold=getVolumeThreshold(volume)
% Get the threshold of volume for rejecting a pitch

testNum=4;
threshold=floor(sum(volume(1:testNum))/2);
if (threshold<256/2) | (threshold>10*256)
	threshold=2*256;
end

% threshold=floor(max(volume)/4);