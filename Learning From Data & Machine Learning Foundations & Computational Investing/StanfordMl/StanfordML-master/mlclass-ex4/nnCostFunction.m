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

yvec = zeros(length(y), max(y)); %turn y into a vector
for i=1:length(y),
    yvec(i,y(i))=1;
end

% Add ones to the X data matrix
X = [ones(m, 1) X];
hidden = sigmoid(X * Theta1');
m2 = size(hidden, 1);
hidden = [ones(m2, 1) hidden];
out = sigmoid(hidden * Theta2');

tmp = -1 * yvec .* log(out) - (1 - yvec) .* log(1 - out);
J = 1 / m * sum(tmp(:)); %tmp(:) arranges tmp into column vector, then we take the sum

tmp1 = Theta1(:,2:end) .* Theta1(:,2:end);
reg1 = sum(tmp1(:));
tmp2 = Theta2(:,2:end) .* Theta2(:,2:end);
reg2 = sum(tmp2(:));
J = J + lambda / (2*m) * (reg1 + reg2);

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
Del1 = zeros(size(Theta1));
Del2 = zeros(size(Theta2));
for t = 1:m,
% step 1 - forward propagation
    a1 = X(t,:);
    z2 = a1 * Theta1';
    a2 = sigmoid(z2);
    a2 = [1, a2];
    z3 = a2 * Theta2';
    a3 = sigmoid(z3);
% step 2
    del3 = a3 - yvec(t,:);
% step 3
    tmp = del3 * Theta2;
    del2 = tmp(2:end) .* sigmoidGradient(z2);
% step 4
    Del1 = Del1 + del2' * a1;
    Del2 = Del2 + del3' * a2;
end
% step 5
Theta1_grad = 1 / m * Del1;
Theta2_grad = 1 / m * Del2;
    
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

g11 = 1 / m * Del1;
Theta1_grad = 1 / m * Del1 + lambda / m * Theta1;
Theta1_grad(:,1) = g11(:,1);
g21 = 1 / m * Del2;
Theta2_grad = 1 / m * Del2 + lambda / m * Theta2;
Theta2_grad(:,1) = g21(:,1);

%r1 = size(Theta1, 2);
%r2 = size(Theta2, 2);
%for j=2:r1,
%    Theta1_grad(:,j) = Theta1_grad(:,j) + lambda / m + Theta1(:,j);
%end
%for j=2:r2,
%    Theta2_grad(:,j) = Theta2_grad(:,j) + lambda / m + Theta2(:,j);
%end


















% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
