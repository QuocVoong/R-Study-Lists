1;

clear all;

addpath ("./common");

% Enables weight decay. Change this to 1 to enable regularization
wd = 0;

% Weight decay parameter. Change this according to question
k = -3;

% Loads the training data with transformations
[X y] = q2data ("../data/in.dta");

% Applies linear regression with regularization (if wd == 1)
w = linearreg (X, y, wd, k);

% Calculates the in-sample error
ein = q2err (w, "../data/in.dta");

% Calculates the out-of-sample error
eout = q2err (w, "../data/out.dta");

printf ("Ein = %.3f, Eout = %.3f\n", ein, eout);
