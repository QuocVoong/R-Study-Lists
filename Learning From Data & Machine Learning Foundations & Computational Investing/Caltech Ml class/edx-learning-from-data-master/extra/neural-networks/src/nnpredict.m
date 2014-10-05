% Feeds an example through a pretrained model and returns the sign of the output signal
function y = nnpredict (model, x)
  nmodel = nnfeedforward (model, x);
  y = sign (nmodel.layer(end).signal);
end
