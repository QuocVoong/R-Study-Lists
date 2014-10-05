1;

clear all;

addpath ("./common");

% Number of points
N = 100;

% Number of dimensions
d = 2;

% Number of clusters for regular RBF
K = 9;

% Gammas
gammas = [1.5 2];

% Input space
spc = [-1 1];

% Number of runs
runs = 100;

rundata = [];

for run = 1:runs

  % N random examples
  X = inputdata (N, d, spc);
  y = arrayfun (@ (n) target (X(n,:)), 1:N)';

  % Generates N new random examples for testing (Eout)
  Xtest = inputdata (N, d, spc);
  ytest = arrayfun (@ (n) target (Xtest(n,:)), 1:N)';

  for i = 1:length (gammas)
    gamma = gammas(i);

    % Computes the weights using regular RBF with K centers
    do
      rbfmodel = rbf (X, y, gamma, K);
    until rbfmodel.ok;

    % Computes in-sample and out-of-sample error
    ein  = errrbf (rbfmodel, X, y);
    eout = errrbf (rbfmodel, Xtest, ytest);

    rundata(run, 2*i-1) = ein;
    rundata(run, 2*i) = eout;
  end
end

deltaein  = rundata(:,1) - rundata(:,3);
deltaeout = rundata(:,2) - rundata(:, 4);

deltas = sign ([deltaein deltaeout]);

% When Ein and Eout on a given lambda goes on opposite directions
diff = deltas (find (deltas(:,1) != deltas(:,2)),:);

printf ("How many times Ein didn't change but Eout went up: %d\n", ...
          sum (diff (find (diff(:,1) == 0),:)(:,2) == -1));

printf ("How many times Ein didn't change but Eout went down: %d\n", ...
          sum (diff (find (diff(:,1) == 0),:)(:,2) == 1));

printf ("How many times Ein went up but Eout didn't change: %d\n", ...
          sum (diff (find (diff(:,1) == -1),:)(:,2) == 0));

printf ("How many times Ein went down but Eout didn't change: %d\n", ...
          sum (diff (find (diff(:,1) == 1),:)(:,2) == 0));

printf ("How many times Ein went down but Eout went up: %d\n", ...
          sum (diff (find (diff(:,1) == 1),:)(:,2) == -1));

printf ("How many times Ein went up but Eout went down: %d\n", ...
          sum (diff (find (diff(:,1) == -1),:)(:,2) == 1));

printf ("How many times both Ein and Eout didn't change: %d\n", ...
          sum (deltas(find (deltas(:,1) == 0),:)(:,2) == 0));

printf ("How many times both Ein and Eout went down: %d\n", ...
          sum (deltas(find (deltas(:,1) == 1),:)(:,2) == 1));

printf ("How many times both Ein and Eout went up: %d\n", ...
          sum (deltas(find (deltas(:,1) == -1),:)(:,2) == -1));
