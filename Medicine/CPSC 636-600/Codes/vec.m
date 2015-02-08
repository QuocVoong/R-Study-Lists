
function v = vec(X)

 [r,c] = size(X);

  v = reshape(X,r*c,1);

end
