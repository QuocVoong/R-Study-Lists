1;

clear all;

addpath ("./common");

% Loads training/validation data from file
[X y] = loaddata ("../data/in.dta");

% Loads test set
[Xo yo] = loaddata ("../data/out.dta");

% Transforms data to the Z input space
X = transform (X);
Xo = transform (Xo);

% Number of examples used for training. Change this according to question
Nt = 25;

% Picks examples used for testing
Xt = X(1:Nt,:);
yt = y(1:Nt,:);

% Picks examples used for validation
Xv = X(Nt+1:end,:);
yv = y(Nt+1:end,:);

% Let's try a bunch of values for K
ks = 3:7;

% Uncomment the following lines in order to reverse training and validation sets
% [Xt Xv] = deal (Xv, Xt);
% [yt yv] = deal (yv, yt);

% Error measures collected across iterations
errval = [];

for i = 1:length (ks)

  % Value of k for this iteration
  k = ks(i);

  % Selects the model for this iteration
  Xtk = Xt(:,1:k+1);
  Xvk = Xv(:,1:k+1);
  Xok = Xo(:,1:k+1);

  % Runs linear regression without regularization
  w = linearreg (Xtk, yt, 0, 0);

  % Evaluates the validation and test error for the current model
  errval(i,:) = [k err(w, Xvk, yv) err(w, Xok, yo)];
end

% Finds the best entry based on validation and test error
bval = find (min (errval(:,2)) == errval(:,2));
btest = find (min (errval(:,3)) == errval(:,3));

printf ("Best considering validation error: k = %d, Eout = %.1f\n", errval (bval,[1 2]));
printf ("Best considering test error: k = %d, Eout = %.1f\n", errval (btest,[1 3]));
