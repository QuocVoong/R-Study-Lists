% Replace the ? with an integer between 2 and 1000
n=linspace(0,1,1024);
s=sin(2.*pi.*1.*n)+.3.*sin(2.*pi.*4.*n);                  
x=s+.1.*randn(size(s));
L=100;
%The following code filters and then plots the output
%In future lectures we will learn what exactly is 
%happening in this "filtering" process!
y=cconv(x,ones(1,L)./L,1024);
figure,plot(y);
xlabel('n'),ylabel('y[n]'),title('Output y[n]')   