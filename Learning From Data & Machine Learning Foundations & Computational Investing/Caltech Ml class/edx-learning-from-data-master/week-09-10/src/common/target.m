% Slightly nonlinear target function
function y = target (x)
  y = sign (x(2) - x(1) + 0.25 * sin (pi * x(1)));
end
