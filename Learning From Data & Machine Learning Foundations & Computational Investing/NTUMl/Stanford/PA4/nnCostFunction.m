function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

function mat = addone_horz(M)
	sz = size(M,2);
	o = ones(1,sz);
	mat = [ o ; M];
end

function [a1,a2,a3,z2,z3] = h(X,t1,t2)
	a1 = addone_horz(X');
	z2 = t1 * a1;
	a2 = addone_horz(sigmoid(z2));
	z3 = t2 * a2;
	a3 = sigmoid(z3);
end

	
function mat = gety(x,num_labels)
	mat = zeros(num_labels,1);
	mat(x) = 1;
end


for i=1:m
	tx = X(i,:);
	ty = gety(y(i),num_labels);
	[a1,a2,a3,z2,z3]=h(tx,Theta1,Theta2);
	J += ty' * log(a3) + (1.0 - ty') * log(1.0 - a3);
	Delta3 = a3 - ty;
	Delta2 = (Theta2' * Delta3)(2:end) .* sigmoidGradient(z2);
	Theta1_grad += (a1 * Delta2')';
	Theta2_grad += (a2 * Delta3')';
end

function reg = regTheta(M,lambda,m)
	M = M(:,2:end);
	reg = [zeros(size(M,1),1) M];
	reg *= lambda;
	reg /= m;
end
J /= m;
Theta1_grad /= m;
Theta2_grad /= m;
Theta1_grad += regTheta(Theta1,lambda,m);
Theta2_grad += regTheta(Theta2,lambda,m);

J *= -1;


function x = regsum(M)
	tmp = M(:,2:size(M,2));
	x = sum(sum(tmp.^2));
end
J += lambda / 2.0 / m * (regsum(Theta1) + regsum(Theta2));





% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
