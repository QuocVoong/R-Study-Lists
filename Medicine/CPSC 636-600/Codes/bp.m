%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% function [w_hid, w_out, output, hidden, err_curve] 
%	= bp(I,D,n_hidden,eta,n_max,[learned_w_hid, learned_w_out])
%
%	arguments:
%
%		I: input matrix, with each row being an input vector
%
%		+---------------+
%		|      x1       |
%		+---------------+
%		|      x2       |
%		+---------------+
%		|      x3       |
%		+---------------+
%		|      x4       |
%		+---------------+
%
%		D: output matrix, with each row being an input vector
%
%		+---------------+
%		|      D1       |
%		+---------------+
%		|      D2       |
%		+---------------+
%		|      D3       |
%		+---------------+
%		|      D4       |
%		+---------------+
%
%		n_hidden: number of hidden layer nodes
%
%		eta: learning rate
%	
%		n_max: number of epochs to train
%
%		learned_w_hid (optional): trained input-to-hidden weight matrix
%
%		learned_w_out (optional): trained hidden-to-output weight matrix
%
%
%	returned values:
%
%		w_hid: input-to-hidden weight matrix with each column
%			holding the weights for each hidden neuron.
%			Last row is the bias weight.
%
%		w_out: hidden-to-output weight matrix with each column
%			holding the weights for each output neuron.
%			Last row is the bias weight.
%
%
%		output: matrix holding all output vectors for all input
%			patterns. Each row holds the output vector
%			for each input pattern in the matrix I.
%
%		hidden: matrix holding all hidden vectors for all input
%			patterns. Each row holds the hidden vector
%			for each input pattern in the matrix I.
%			
%		err_curve: matrix holding error in each output unit
%			for all input patterns. Each row holds the
%			error vector for that particular input pattern.
%
%			mean(err_curve') give the overall mean error.
%	
% Examples:
%
% 1. XOR
%
% [w_hid, w_out, output, hidden, err_curve] = bp([-1 -1 ; -1 1; 1 -1; 1 1], [-1; 1; 1; -1], 2, 0.1, 2000); 
%
% 2. autoassociation
%
% [w_hid, w_out, output, hidden, err_curve] = bp(eye(8,8)*2-1, eye(8,8)*2-1, 3, 0.05, 10000);
%
% 3. function approximation
%
% x = [-pi:0.1:pi]; fx = sin(x);
% [w_hids, w_outs, outputs, hiddens, err_curves] = bp(x'/pi,fx', 4, 0.1,4000);
%
% Author: Yoonsuck Choe
% http://faculty.cs.tamu.edu
% Sat Feb  9 16:14:37 CST 2008
% License: GNU public license (http://www.gnu.org)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [w_hid, w_out, output, hidden, err_curve] = bp(I,D,n_hidden,eta,n_max, l_w_hid, l_w_out)

%----------------------------------------
% 1. Setup network weights
%----------------------------------------

[r_inp,c_inp] = size(I);
n_patterns = r_inp;	   	% number of input patterns
n_input    = c_inp; 
n_hidden   = n_hidden;   

[r_out,c_out] = size(D);
n_output   = c_out; 

%----------------------------------------
% 2. Check if weight matrix is given and use it if so.
%----------------------------------------
if (nargin>5) 
  w_hid = l_w_hid;
  w_out = l_w_out;
  n_max = 1;
  learn_flag = 0;
else
  w_hid = rand(n_input+1,n_hidden);
  w_out = rand(n_hidden+1,n_output);
  learn_flag = 1;
end

%----------------------------------------
% 3. Initialize error curve matrix.
%    Each output unit will have a separate error curve.
%    Each iteration is stored in one row.
%----------------------------------------
err_curve = zeros(n_max,c_out);

% 4. Main loop
for n=1:n_max % (epoch)

  output = [];
  hidden = [];

  err_sum = zeros(1,c_out);

  for k=1:n_patterns 
	
    %--------------------
    % 1. activate
    %--------------------
    hid_act = tanh([I(k,:),1]*w_hid);
    hidden = [hidden; hid_act];
    out_act = tanh([hid_act,1]*w_out);
    output = [output; out_act];

    %--------------------
    % 2. calculate error
    %--------------------
    err = D(k,:)-out_act;
    err_sum = err_sum + abs(err);

    if (learn_flag==0) 
       continue;
    end

    %--------------------
    % 3. update hidden-to-output weight
    %--------------------
    %    * Note that tanh'(x) = (1-tanh(x)^2).
    del_out = (1.-out_act.^2).*err;
    %    * Note the '1' at the end of [hid_act,1]' is the bias.
    delta_w = eta*[hid_act,1]'*del_out;
    w_out = w_out+delta_w;

    %--------------------
    % 4. calculated backpropagated delta for all hidden units
    %--------------------
    %    * You need del_out and w_out to calculate this.
    w_sum_del = w_out*del_out';

    %--------------------
    % 5. update input-to-hidden weight
    %--------------------
    %    * You need hid_act and w_sum_del to calculate this.
    %    * Note that tanh'(x) = (1-tanh(x)^2).
    % FILL IN THIS LINE
    del_hid = 
    %    * You need eta, input I, and del_hid to calculate this.
    % FILL IN THIS LINE
    delta_w = 
    %    * You need w_hid and delta_w to calculate this.
    % FILL IN THIS LINE
    w_hid = 
    
  end

  err_curve(n,:) = err_sum/n_patterns;

  % print out progress
  % for matlab, use
  fprintf('epoch %d: err %f\n',n,mean(err_sum)/n_patterns);
  
end
