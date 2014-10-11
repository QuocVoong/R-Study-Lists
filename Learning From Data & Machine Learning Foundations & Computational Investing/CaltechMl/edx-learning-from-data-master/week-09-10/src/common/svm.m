% Runs hard-margin SVM with RBF kernel
function model = svm (X, y, gamma, Q)
  opts = sprintf ("-s 0 -t 2 -g %f -r 1 -c %d -q -h 0", gamma, Inf);

  if (Q)
    opts = sprintf ("%s -d %d", opts, Q);
  end

  model = svmtrain (y, X, opts);
end
