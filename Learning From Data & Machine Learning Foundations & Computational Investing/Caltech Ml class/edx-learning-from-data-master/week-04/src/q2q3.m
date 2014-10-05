1;

addpath ("./common");

% Number of examples. Change this according to the question
N = 5;

% Probability that epsilon will hold
delta = 0.05;

% VC dimension
dvc = 50;

printf ("Original VC bound: %f\n", vc (N, dvc, delta));
printf ("Rademacher bound: %f\n", rademacher (N, dvc, delta));
printf ("Parrondo bound: %f\n", parrondo (N, dvc, delta));
printf ("Devroye bound: %f\n", devroye (N, dvc, delta));
