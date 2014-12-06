objFunction='humps';		% Objective function
optimPrm.searchRange=[0.0, 1.0];
optimPrm.evalCount=9;
optimPrm.plotOpt=1;
[minPair, allPairs]=binarySearch4min(objFunction, optimPrm);
fprintf('minX=%f, minY=%f\n', minPair(1), minPair(2));
x=linspace(optimPrm.searchRange(1), optimPrm.searchRange(2), 101);
y=humps(x);
line(x, y, 'color', 'r'); grid on
set(gca, 'ylim', [min(y), max(y)]);