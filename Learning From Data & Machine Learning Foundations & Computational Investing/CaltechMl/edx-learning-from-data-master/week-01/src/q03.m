1;

% Solving this using Monte Carlo method

% Number of times the experiment will run in order to average the probability
iters = 9999;

% Number of marbles on each bin
nmarbles = 2;

% Two bins containing white marbles (0) and black marbles (1)
bins = [ [0 1] ; [1 1] ];

% Result of each iteration
results = zeros (iters, 1);

for i = 1:iters

  % Picks a random bin
  bin = bins(randperm (length (bins)), :)(1, :);

  % Shuffles the marbles
  marbles = bin(:, randperm (nmarbles));

  % This experiment should not be considered if the first marble is not black
  if marbles(1) != 1
    results(i) = 2;
    continue;
  end

  % Picks the remaining marble from the bin
  results(i) = marbles(2);
end

% Removes the invalid experiments
results = results(find (results != 2));

printf("Probability of picking two black marbles from a random bag: %.6f\n", mean (results));
