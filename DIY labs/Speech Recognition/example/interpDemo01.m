n=10;
x=1:n;
y=rand(1,n);		% Original vector (原始向量)
ratio=1.8;		% The vector interpolation should have a length equal to 1.8 times the original vector
x2=1:1/ratio:n;
y2=interp1(x, y, x2);	% Vector after interpolation
subplot(2,1,1), plot(x, y, 'o-', x2, y2, 'o:');
subplot(2,1,2), plot(1:length(y), y, 'o-', 1:length(y2), y2, 'o:');
fprintf('Desired length ratio = %f\n', ratio);
fprintf('Actual length ratio = %f\n', length(y2)/length(y));