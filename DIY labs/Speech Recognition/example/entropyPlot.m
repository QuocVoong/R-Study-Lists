pointNum = 101;
x = linspace(eps, 1-eps, pointNum);
y = -x.*log(x)-(1-x).*log(1-x);

subplot(2,2,1); plot(x,y); axis([-inf inf 0 0.8]);
xlabel('p_1'); title('(a) Entropy Function with two inputs'); 

pointNum = 31;
x = linspace(eps, 1-eps, pointNum);
[xx, yy] = meshgrid(x);
ind = find(1-xx-yy < eps);
xx(ind) = nan*ind; yy(ind) = nan*ind;
zz = -xx.*log(xx)-yy.*log(yy)-(1-xx-yy).*log(1-xx-yy);

subplot(2,2,2); mesh(xx, yy, zz);
axis([-inf inf -inf inf 0 1.1]);
xlabel('p_1'); ylabel('p_2'), title('(b) Entropy Function with three inputs'); 
view([60 10]);
set(gca, 'box', 'on');