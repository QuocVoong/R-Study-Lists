% ====== Set up some parameters
frameNum=100;
stateNum=10;
symbolNum=64;
initPI=log([1, zeros(1, stateNum-1)]);
selfTransProb=0.85;
A=diag(selfTransProb*ones(stateNum,1)); A((stateNum+1):(stateNum+1):stateNum^2)=1-selfTransProb; A=A+eps;
A=log(A);
B=rand(symbolNum, stateNum); B=B*diag(1./sum(B));
B=log(B);
O=ceil(rand(frameNum,1)*symbolNum);

% ====== Start functionality and timing tests
n=100;
tic
for j=1:n
	[maxLogProb1, dpPath1, dpTable1] = dhmmEvalMex(initPI, A, B, O);
end
fprintf('dhmmEvalMex ==> %.2f, maxLogProb = %.9f\n', toc, maxLogProb1);
tic
for j=1:n
	[maxLogProb2, dpPath2, dpTable2] = dhmmEval(initPI, A, B, O);
end
fprintf('dhmmEval ==> %.2f, maxLogProb = %.9f\n', toc, maxLogProb2);

fprintf('Difference in maxLogProb = %g\n', abs(maxLogProb1-maxLogProb2));
fprintf('Difference in dpPath = %g\n', sum(sum(abs(dpPath1-dpPath2))));
fprintf('Difference in dpTable = %g\n', sum(sum(abs(dpTable1-dpTable2))));