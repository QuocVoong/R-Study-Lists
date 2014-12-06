function frame2=frameFlip(frame, plotOpt)

if nargin<2, plotOpt=0; end

frameSize=length(frame);
energy1=sum(abs(frame(1:frameSize/2)));
energy2=sum(abs(frame(frameSize/2+1:end)));
frame2=frame;
if energy1<energy2
	frame2=fliplr(flipud(frame));
	if plotOpt, fprintf('­µ®ØÃè®g¡I\n'); end
end