function [minDistance, dtwPath, dtwTable]=dtw3(vec1, vec2, beginCorner, endCorner)
% dtw3: Dynamic time warping with local paths of 0 and 45 degrees
%	Usage: [minDistance, dtwPath, dtwTable]=dtw3(vec1, vec2, beginCorner, endCorner, plotOpt)
%		vec1: testing vector, which should be a pitch vector
%		vec2: reference vector, which should be a vector of note pitch
%		minDistance: minimun distance of DTW
%		dtwPath: optimal path of dynamical programming through the DTW table
%			(Its size is 2xk, where k is the path length.)
%		dtwTable: DTW table

if nargin<3, beginCorner=1; end
if nargin<4, endCorner=1; end

% If input is vector, make it row vector
if size(vec1,1)==1 | size(vec1,2)==1, vec1 = vec1(:)'; end
if size(vec2,1)==1 | size(vec2,2)==1, vec2 = vec2(:)'; end

size1=length(vec1);
size2=length(vec2);

% ====== Construct DTW table
dtwTable=inf*ones(size1,size2);
% ====== Construct the first element of the DTW table
dtwTable(1,1)=vecDist(vec1(:,1), vec2(:,1));
% ====== Construct the first row of the DTW table (xy view)
for i=2:size1
	dtwTable(i,1)=dtwTable(i-1,1)+vecDist(vec1(:,i), vec2(:,1));
	prevPos(i,1).i=i-1;
	prevPos(i,1).j=1;
end
% ====== Construct the first column of the DTW table (xy view)
if beginCorner==0
	for j=2:size2
		dtwTable(1,j)=vecDist(vec1(:,1), vec2(:,j));
		prevPos(1,j).i=[];
		prevPos(1,j).j=[];
	end
end

% ====== Construct all the other rows of DTW table
for i=2:size1
	for j=2:size2
		pointDist=vecDist(vec1(:,i), vec2(:,j));
		% ====== Check 45-degree predecessor
		...
		% ====== Check 0-degree predecessor
		...
	end
end

% ====== Find the overall optimum path
[minDistance, dtwPath]=dtwBackTrack(dtwTable, prevPos, beginCorner, endCorner);

% ========== Sub function ===========
function distance=vecDist(x, y)
distance=sum(abs(x-y));