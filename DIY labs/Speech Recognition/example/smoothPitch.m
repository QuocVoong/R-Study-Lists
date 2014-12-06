function [out, changed] = smoothPitch(in, plotOpt)
%SMOOTHPITCH Trim the pitch vector, where 0 indicates rest.
%	Note that this file should always be sync with smoothPitchMex.c

%	Roger Jang, 20010331

if nargin==0, selfdemo; return; end
if nargin<2, plotOpt=0; end

out=in; changed=0*in;
pitchScale=10;
plotNum=7; plotIndex=0;

% 找出中位數
temp=in; temp(temp==0)=[]; medianPitch=median(temp);

in=out; action='消掉單獨一個暴音（三點都不是 0，端點不可相差超過 9 個半音，相鄰點相差超過 4 個半音）';
[out, changed]=removeSingleJump(in, pitchScale); 
if plotOpt, plotIndex=plotIndex+1; plotPitch(in, out, changed, plotNum, plotIndex, action); end

in=out; action='重複上一步';
[out, changed]=removeSingleJump(in, pitchScale); 
if plotOpt, plotIndex=plotIndex+1; plotPitch(in, out, changed, plotNum, plotIndex, action); end

in=out; action='消掉單獨一個在邊緣暴音（中間點不為 0，左點或右點是 0）';
[out, changed]=removeSingleJumpAtEdge(in, pitchScale);
if plotOpt, plotIndex=plotIndex+1; plotPitch(in, out, changed, plotNum, plotIndex, action); end

in=out; action='消掉連續兩個暴音（端點不可相差超過 9 個半音，相鄰點相差超過 4 個半音）';
[out, changed]=removeDoubleJump(in, pitchScale); 
if plotOpt, plotIndex=plotIndex+1; plotPitch(in, out, changed, plotNum, plotIndex, action); end

in=out; action='重複上一步';
[out, changed]=removeDoubleJump(in, pitchScale); 
if plotOpt, plotIndex=plotIndex+1; plotPitch(in, out, changed, plotNum, plotIndex, action); end

in=out; action='pitch中各點與median差不能超過10個半音';
[out, changed]=removeOutOfBound(in, pitchScale); 
if plotOpt, plotIndex=plotIndex+1; plotPitch(in, out, changed, plotNum, plotIndex, action); end

in=out; action='刪去 00x00';
[out, changed]=removePattern00x00(in, pitchScale); 
if plotOpt, plotIndex=plotIndex+1; plotPitch(in, out, changed, plotNum, plotIndex, action); end


% ====== Sub-functions
% ====== 消掉單獨一個暴音（三點都不是 0，端點不可相差超過 9 個半音，相鄰點相差超過 4 個半音）
function [out, changed]=removeSingleJump(in, pitchScale);
out=in; changed=0*in;
for i=2:length(in)-1,
	if all(in(i-1:i+1)~=0),
		if abs(in(i-1)-in(i+1))<9*pitchScale, % （端點不可相差超過 9 個半音）
			if abs(in(i)-in(i-1))>4*pitchScale & abs(in(i)-in(i+1))>4*pitchScale,
				out(i) = floor((in(i-1)+in(i+1))/2);
				changed(i) = 1;
			end
		end
	end
end

% ====== 消掉單獨一個在邊緣暴音（中間點不為 0，左點或右點是 0）
function [out, changed]=removeSingleJumpAtEdge(in, pitchScale)
out=in; changed=0*in;
i=1;
if (in(i)~=0) & (abs(in(i)-in(i+1))>4*pitchScale) & (in(i+2)~=0)	% 處理第一點
	out(i)=in(i+1);
	changed(i) = 1;
end
i=length(in);
if (in(i)~=0) & (abs(in(i)-in(i-1))>4*pitchScale) & (in(i-2)~=0)	% 處理最後一點
	out(i)=in(i-1);
	changed(i) = 1;
end
for i=2:length(in)-2,	% 中間點不是 0，左點是 0，右兩點不是 0 
	if (in(i-1)==0) & (in(i)~=0) & (in(i+1)~=0) & (in(i+2)~=0) & (abs(in(i)-in(i+1))>4*pitchScale),	% 左點是 0
		out(i)=in(i+1);
		changed(i) = 1;
	end
end
for i=3:length(in)-1,	% 中間點不是 0，右點是 0，左兩點不是 0
	if (in(i-2)~=0) & (in(i-1)~=0) & (in(i)~=0) & (in(i+1)==0) & (abs(in(i)-in(i-1))>4*pitchScale),	% 右點是 0
		out(i)=in(i-1);
		changed(i) = 1;
	end
end

% ====== 消掉連續兩個暴音（端點不可相差超過 9 個半音，相鄰點相差超過 4 個半音）
function [out, changed]=removeDoubleJump(in, pitchScale)
out=in; changed=0*in;
for i=2:length(in)-2,
	if all(in(i-1:i+2)~=0),
		if abs(in(i-1)-in(i+2))<9*pitchScale, % （端點不可相差超過 7 個半音）
%			if abs(in(i)-in(i+1))>4*pitchScale & abs(in(i+2)-in(i+3))>4*pitchScale & abs(in(i+1)-in(i+2))<2*pitchScale
			if abs(in(i-1)-in(i))>4*pitchScale & abs(in(i+1)-in(i+2))>4*pitchScale,
				out(i) = floor((2*in(i-1)+in(i+2))/3);
				out(i+1) = floor((in(i-1)+2*in(i+2))/3);
				changed(i) = 1;
				changed(i+1) = 1;
			end
		end
	end
end

% ====== 消掉00x00
function [out, changed]=removePattern00x00(in, pitchScale)
out=in; changed=0*in;
if ((in(1)~=0) & (in(2)==0) & (in(3)==0)), out(1)=0; end	% 第一點
if ((in(1)==0) & (in(2)~=0) & (in(3)==0) & (in(4)==0)), out(2)=0; end	% 第二點
if ((in(end-2)==0) & (in(end-1)==0) & (in(end)~=0)), out(end)=0; end	% 倒數第一點
if ((in(end-3)==0) & (in(end-2)==0) & (in(end-1)~=0) & (in(end)==0)), out(end-1)=0; end	% 倒數第二點
for i=3:length(in)-2
	if ((in(i-2)==0) & (in(i-1)==0) & (in(i)~=0) & (in(i+1)==0) & (in(i+2)==0)), out(i)=0; end
end
i=1;
if (in(i)~=0) & (abs(in(i)-in(i+1))>4*pitchScale) & (in(i+2)~=0)	% 處理第一點
	out(i)=in(i+1);
	changed(i) = 1;
end
i=length(in);
if (in(i)~=0) & (abs(in(i)-in(i-1))>4*pitchScale) & (in(i-2)~=0)	% 處理最後一點
	out(i)=in(i-1);
	changed(i) = 1;
end
for i=2:length(in)-2,	% 中間點不是 0，左點是 0，右兩點不是 0 
	if (in(i-1)==0) & (in(i)~=0) & (in(i+1)~=0) & (in(i+2)~=0) & (abs(in(i)-in(i+1))>4*pitchScale),	% 左點是 0
		out(i)=in(i+1);
		changed(i) = 1;
	end
end
for i=3:length(in)-1,	% 中間點不是 0，右點是 0，左兩點不是 0
	if (in(i-2)~=0) & (in(i-1)~=0) & (in(i)~=0) & (in(i+1)==0) & (abs(in(i)-in(i-1))>4*pitchScale),	% 右點是 0
		out(i)=in(i-1);
		changed(i) = 1;
	end
end

% ====== pitch 中各點與 median 差不能超過10個半音
function [out, changed]=removeOutOfBound(in, pitchScale)
out=in; changed=0*in;
temp=in;
temp(temp==0)=[];
m=median(temp);

%調第一點在bound內
i=1;
while in(i)==0,
    i=i+1;
end
if abs(in(i)-m)>=100,
    j=i;
    while abs(in(j)-m)>=100,
        j=j+1;
    end
    out(i)=in(j);
	changed(i) = 1;
end
%調最後一點在bound內
j=length(in);
while in(j)==0,
    j=j-1;
end
if abs(in(j)-m)>=100,
    k=j;
    while abs(in(k)-m)>=100,
        k=k-1;
    end
    out(j)=in(k);
 	changed(j) = 1;
end
%調中間點在bound內
for x=i:length(in)-1,
    if out(x)~=0 & abs(out(x)-m)>=100,
        j=x-1;
        while abs(out(j)-m)>=100,
            j=j-1;
        end
        k=x+1; 
        while abs(out(k)-m)>=100,
            k=k+1;
        end
        for x=j+1:k-1,
            if out(x)~=0,
                if out(k)-out(j) == 0,
                    out(x)=out(j);
                else
                    out(x)=out(j)+(x-j)*intDiv((out(k)-out(j)),(k-j));
                end
                changed(x) = 1;
            end
        end
    end
end


% ====== 畫出 pitch
function plotPitch(in, out, changed, plotNum, plotIndex, titleStr)
in(in==0)=nan;
out(out==0)=nan;
% Find median pitch
temp=in;
temp(isnan(temp))=[];
medianPitch=median(temp);
subplot(plotNum,1,plotIndex);
% start plotting
plot(1:length(in), in, '.-b', 1:length(out), out, '.-r');
line([1, length(in)], medianPitch*[1 1], 'color', 'g');
line([1, length(in)], medianPitch*[1 1]+100, 'color', 'r');
line([1, length(in)], medianPitch*[1 1]-100, 'color', 'r');
index = find(changed==1);
line(index, out(index), 'marker', 'o', 'linestyle', 'none', 'color', 'k');
axis tight; grid on
title(titleStr);
xlabel('Time (seconds)');
ylabel('Pitch');

% ====== selfdemo
function selfdemo
% === First plot
testPitch = 10*[5 5 20 4 4];
testPitch = 10*[0 6 7 12 0 0 0 13 7 6 6 0 6 6 0 0 7 7 14 14 8 8 3 2 8 8 7 13 8 8 8 8 13 0 0];
[p1, changed] = feval(mfilename, testPitch, 1);
% === Second plot
waveFile='testWav/yankee doodle.wav';
[pitch, volume, PP]=wave2pitchVolume(waveFile);
pitch(volume<getVolumeThreshold(volume))=0;
figure;
[p1, changed] = feval(mfilename, pitch, 1);