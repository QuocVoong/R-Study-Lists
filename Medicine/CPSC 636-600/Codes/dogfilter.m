% function M = dogfilter(X,n)
%	return n x n DoG filtered matrix M or X

function M = dogfilter(X,n)


   	c = round(n/2);
	s1 = n/4;
	s2 = n/8;

  	x = (1:n)'*(zeros(1,n)+1)-c;
  	y = (zeros(n,1)+1)*(1:n)-c;
  	xsq = ((x*cos(0) + y*sin(0)).^2)/(s1^2);
  	ysq = ((-x*sin(0) + y*cos(0)).^2)/(s1^2);
  	g1 = exp(-(xsq+ysq));

  	x = (1:n)'*(zeros(1,n)+1)-c;
  	y = (zeros(n,1)+1)*(1:n)-c;
  	xsq = ((x*cos(0) + y*sin(0)).^2)/(s2^2);
  	ysq = ((-x*sin(0) + y*cos(0)).^2)/(s2^2);
  	g2 = exp(-(xsq+ysq));

	[r,c]=size(g2);
	g = g2/sum(reshape(g2,r*c,1))-g1/sum(reshape(g1,r*c,1));

	M = real(conv2(X,g,'same'));


