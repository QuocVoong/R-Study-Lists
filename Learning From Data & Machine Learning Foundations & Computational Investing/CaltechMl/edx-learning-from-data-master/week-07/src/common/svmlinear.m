% Linear kernel for svm
function k = svmlinear ()
  k = @ (x, xp) x * xp';
end
