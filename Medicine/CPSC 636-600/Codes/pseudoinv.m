%
%
% Example of pseudoinverse (for linear least-square filter)
%
% Yoonsuck Choe
% Sat Jan 26 15:08:22 CST 2008
% http://faculty.cs.tamu.edu/choe
%

% Set up the input matrix (each row is one input vector)

X = ceil(rand(5,3)*10)

% Set up the true weight vector

wtrue = rand(3,1)*10

% Use true weight vector to generate target values

d=X*wtrue

% Learn weight using least-square filter (pseudo inverse) from
% the input X and target d.

w = inv(X'*X)*X'*d


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Example output
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% X =
% 
%    5   4   3
%    3   6   2
%    6   2   2
%   10   9   3
%    8   7   7
% 
% wtrue =
% 
%   3.6670
%   1.0777
%   8.1483
% 
% d =
% 
%   47.091
%   33.764
%   40.454
%   70.814
%   93.918
% 
% w =
% 
%   3.6670
%   1.0777
%   8.1483
% 
% 
