function [model epochs] = neuralnet (X, y, Lu, theta, thetad, eta, deltat, maxepochs)

  epochs = 0;

  % Initializes the network
  nmodel.layer = nninitmodel (X, Lu);

  % Sets the model parameters to the struct
  nmodel.theta = theta;
  nmodel.thetad = thetad;
  nmodel.eta = eta;

  for raa = 1:maxepochs

    % Previous model kept for comparison
    pmodel = nmodel;

    % For each training example
    for n = 1:size (X, 1)

      % Current example
      xn = X(n,:);
      yn = y(n);

      % Processes this iteration and gets a new model
      nmodel = nnfeedforward (nmodel, xn);
      nmodel = nnbackprop (nmodel, xn, yn);
      nmodel = nnupdatew (nmodel, xn);
    end

    epochs += 1;
    model = nmodel;

    % Stop when the change in the final error is neglegible
    if abs (nmodel.layer(end).delta - pmodel.layer(end).delta) <= deltat
      model = nmodel;
      break;
    end
  end
end
