% Runs SVM via the LIBSVM binding for Octave
function model = svm (X, y, Q, C, kt, k)
  % LIBSVM options used:
  % -s svm type
  % -t kernel type
  % -r coefficient
  % -g gamma
  % -c cost for soft margin
  % -d polynomial kernel degree
  % -v k-fold cross-validation
  opts = sprintf ("-s 0 -t %d -r 1 -g 1 -c %f -q -h 0", kt, C);

  if (Q)
    opts = sprintf ("%s -d %d", opts, Q);
  end

  if (k)
    opts = sprintf ("%s -v %d", opts, k);
  end

  model = svmtrain (y, X, opts);

  if (k)
    model = 1 - model / 100;
  end
end
