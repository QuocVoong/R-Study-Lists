% Updates the weights
function nmodel = nnupdatew (model, x)
  nmodel = model;

  for l = fliplr (2:length (nmodel.layer)-1)
    nmodel.layer(l+1).w -= [1 nmodel.layer(l).signal]' * nmodel.layer(l+1).delta;
  end

  nmodel.layer(1).w -= x' * nmodel.layer(1).delta;
end
