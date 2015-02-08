%----------------------------------------------------------------------------
% function [W] = som(inp,nx,ny,n,etas,radii) 
%
%  This is SOM with a 2-dimensional input.
%
%	INPUT:
%
%		inp: an N x 2 input matrix, with each row being 
%		     an input vector.
%
%		+----+----+
%		|    x1   |
%		+----+----+
%		|    x2   |
%		+----+----+
%		|    x3   |
%		+----+----+
%		|    ...  |
%		+----+----+
%		|    xN   |
%		+----+----+
%
%		nx, ny: SOM map size (nx x ny)
%			You can make a 1D SOM my specifying either nx or ny
%			to be 1.
%
%		n: number of iterations to train
%
%		etas: a vector containing a list of learning rates.
%		   This should be of size n, or less. In case
%		   etas is shorter than n, the remaining iterations
%		   will have eta of the last value in etas.
%
%		radii: a vector containing a list of sigma (radius)
%		   parameters. The same rule is used as etas.
%
%
%	OUTPUT: weight vectors
%
%		+----+----+
%		|    W1   |
%		+----+----+
%		|    W2   |
%		+----+----+
%		|    W3   |
%		+----+----+
%		|    ...  |
%		+----+----+
%		|    Wz   |
%		+----+----+
%
%	      	where z = nx x ny. The weight vectors are
%		stored in row major.
%
% Example: 
%
%  inp = rand(1000,2);
%
%  % 2D SOM
%  W = som(inp,10,10,30000,min(0.8,1./(1:5000)*100),max((5000:-1:1)/500,1));
%
%  % 1D SOM
%  W = som(inp,200,1,30000,min(0.8,1./(1:5000)*100),max((5000:-1:1)/100,1));
%
%  Other inputs to try:
%
%	inp=[randn(500,2)/20+0.5;rand(1000,2)];
%	inp=[randn(150,2)/9+0.5;randn(1000,2)/5+ones(1000,2)];
%
% Author: Yoonsuck Choe
% http://faculty.cs.tamu.edu
% Fri Mar 28 14:53:53 CDT 2008
% License: GNU public license (http://www.gnu.org)
%----------------------------------------------------------------------------

function [W] = som(inp,nx,ny,n,etas,radii) 

[N,inp_dim] = size(inp);

[xgrid,ygrid] = meshgrid(1:nx,1:ny);

W = rand(nx*ny,inp_dim);

n_etas = length(etas);
n_radii= length(radii);

%----------------------------------------
% Main loop
%----------------------------------------
for i=1:n

  %----------------------------------------
  % 0. Randomly pick input
  %----------------------------------------
  cur_inp = ceil(rand*N);

  %----------------------------------------
  % 1. Find best matching unit (BMU)
  %----------------------------------------
  [minval,minidx] = min((W(:,1)-inp(cur_inp,1)).^2+(W(:,2)-inp(cur_inp,2)).^2);


  % Plot the map
  if (rem(i,100)==1)
  	wx=reshape(W(:,1),nx,ny);
  	wy=reshape(W(:,2),nx,ny);
	% Turn this on for old versions of octave
	% gset('nokey');
	figure(1);
    	plot([0,0,1,1],[0,1,0,1],'.',W(:,1),W(:,2),'rx',inp(cur_inp,1),inp(cur_inp,2),'bx',W(minidx,1),W(minidx,2),'go',wx,wy,'r-',wx',wy','r-');
  end
  
  %----------------------------------------
  % 2. Find (x,y) coordinate of the BMU
  %----------------------------------------

  bx = rem(minidx-1,nx)+1;
  by = floor((minidx-1)/nx)+1;

  %----------------------------------------
  % 3. update weights
  %----------------------------------------

  %--------------------
  % 3.1 Look up learning rate and radius
  %--------------------
  eta = etas(min(i,n_etas));
  radius = radii(min(i,n_radii));

  %--------------------
  % 3.2 Calculate neighborhood function, 
  %     based on the the BMU location (bx,by)
  %--------------------
  %
  % Use xgrid, ygrid, bx, by, and radius to calculate this matrix.
  %
  lambda =  .....................

  if (rem(i,2500)==1)
	% Plot the neighborhood matrix
	%imagesc(lambda);
  end

  %--------------------
  % 3.3 iterate over all weights
  %--------------------
  for y=1:ny
	for x=1:nx
		idx = x+(y-1)*nx;
	
		% Use W, eta, lambda, x, y, inp, cur_inp, and idx to calculate
		% this weight update step.
  		W(idx,:) = ........................
	end
  end

end
