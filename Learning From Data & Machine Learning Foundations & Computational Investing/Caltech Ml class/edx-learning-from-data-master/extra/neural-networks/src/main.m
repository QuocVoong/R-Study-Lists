1;

clear all;

% Loads the training examples
[Xtrain ytrain] = loaddata ("../data/in.dta");

% Loads the testing examples
[Xtest ytest] = loaddata ("../data/out.dta");

% Learning rate for SGD
eta = 0.1;

% Activation function for each unit in the network
theta = @tanh;

% Partial derivative signal computed by theta
thetad = @ (xn) 1 - (xn .^ 2);

% How many units per layer, in order, including the output unit(s)
Lu = [2 1];

% Stop the process when we hit some local minima
deltat = 1e-5;

% Maximum number of iterations
maxepochs = 1000;

% Trains the neural network
[model epochs] = neuralnet (Xtrain, ytrain, Lu, theta, thetad, eta, deltat, maxepochs);

% In-sample error
ein = nnerr (model, Xtrain, ytrain);

% Out-of-sample error
eout = nnerr (model, Xtest, ytest);

printf ("Epochs: %d\n", epochs);
printf ("Ein:    %.3f\n", ein);
printf ("Eout:   %.3f\n", eout);
