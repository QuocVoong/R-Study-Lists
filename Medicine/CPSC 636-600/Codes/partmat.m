%
%
% Example of partitioned matrices and their manipulation
%
% Mon Jan 21 18:50:58 CST 2008
% Yoonsuck Choe
% http://faculty.cs.tamu.edu/choe
%

% Two matrices X and Y

X = ceil(rand(5,4)*10)

Y = ceil(rand(4,5)*10)

%
% Partition X and Y into AB and EF
%		         CD     GH

A = X([1:3],[1:3]), B=X([1:3],4), C = X([4,5],[1:3]), D = X([4,5],4)

E = Y([1:3],[1:3]), F=Y([1:3],[4:5]), G = Y(4,[1:3]), H = Y(4,[4,5])

% Multiply, partition by partition

[A*E+B*G, A*F+B*H; C*E+D*G, C*F+D*H]

% Compare to the unpartitioned product

X*Y


