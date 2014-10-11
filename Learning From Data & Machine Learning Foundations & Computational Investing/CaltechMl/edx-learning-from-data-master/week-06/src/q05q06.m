1;

clear all;

addpath ("./common");

% Enables weight decay. Change this to 1 to enable regularization
wd = 1;

% Let's try a bunch of values for K to see which one gives best Eout
ks = -2:2;

% Loads the training data with transformations
[X y] = q2data ("../data/in.dta");

% Error measures collected across iterations
err = [];

for i = 1:length(ks)

  % K for this try
  k = ks(i);

  % Applies linear regression with regularization (if wd == 1)
  w = linearreg (X, y, wd, k);

  % Calculates the out-of-sample error
  eout = q2err (w, "../data/out.dta");

  err(i,:) = [k eout];
end

% Finds the best entry based on Eout
best = find (min (err(:,2)) == err(:,2));

printf ("k = %d, Eout = %.2f\n", err (best,:));
