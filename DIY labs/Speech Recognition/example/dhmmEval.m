function [maxLogProb, dpPath, dpTable] = dhmmEval(initPI, A, B, O)
% dhmmEval: Evaluation of DHMM
%	Usage: [maxLogProb, dpPath, dpTable] = viterbiDecoding(initPI, A, B, O)
%		initPI: Initial state log probability, 1 x stateNum
%		A: Transition log probability, stateNum x stateNum
%		B: State log probability, symbolNum x stateNum
%		O: Observation sequence of this utterance, frameNum x 1
%		maxLogProb: Maximum log probability of the optimal path
%		dpPath: optimal path with size frameNum x 1

frameNum = length(O);
stateNum = length(A); 
dpTable = -inf*ones(frameNum, stateNum);

if (stateNum>frameNum); error('Number of frames is less than the number of states!'); end

% ====== Fill the first row (matrix view)
dpTable(1,:)=initPI+B(O(1),:);
% ====== Fill the first column (matrix view)
for i=2:frameNum
	...
end
% ====== Fill each row (matrix view)
for i=2:frameNum
	for j=2:stateNum
		...
	end
end

% ====== Back track to find the optimum path
...