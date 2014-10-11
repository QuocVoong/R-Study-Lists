1;

addpath ("./common");

% Target function
target = @ (x) sin (pi * x);

% Hypothesis function
hypothesis = @ (X, y) linearreg (X, y);

% Number of iterations
iter = 10^4;

% Input distribution
spc = [-1 1];

% Number of points on each sample
nsample = 2;

% Number of examples overall
N = 10^2;

% Calculates Eout based on the bias/variance decomposition for each hypothesis set

% Constant
transform = @ (X) ones (N, 1);
[_, bias, var] = deceout (N, spc, nsample, target, transform, hypothesis, iter);
printf ("Eout h(x) = b is %.2f [bias=%.2f, var=%.2f]\n", ...
        bias + var, bias, var);

% Line that passes through origin (0, 0)
transform = @ (X) X;
[_, bias, var] = deceout (N, spc, nsample, target, transform, hypothesis, iter);
printf ("Eout h(x) = ax is %.2f [bias=%.2f, var=%.2f]\n", ...
        bias + var, bias, var);

% Line with intercept
transform = @ (X) [ones(N, 1) X];
[_, bias, var] = deceout (N, spc, nsample, target, transform, hypothesis, iter);
printf ("Eout h(x) = ax+b is %.2f [bias=%.2f, var=%.2f]\n", ...
        bias + var, bias, var);

% Curve that passes through origin (0, 0)
transform = @ (X) X.^2;
[_, bias, var] = deceout (N, spc, nsample, target, transform, hypothesis, iter);
printf ("Eout h(x) = ax^2 is %.2f [bias=%.2f, var=%.2f]\n", ...
        bias + var, bias, var);

% Curve with intercept
transform = @ (X) [ones(N, 1), X.^2];
[_, bias, var] = deceout (N, spc, nsample, target, transform, hypothesis, iter);
printf ("Eout h(x) = ax^2+b is %.2f [bias=%.2f, var=%.2f]\n", ...
        bias + var, bias, var);
