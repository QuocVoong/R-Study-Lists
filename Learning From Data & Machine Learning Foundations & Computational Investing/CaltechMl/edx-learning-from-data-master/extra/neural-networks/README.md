# Neural Networks

In the discussion forum for Week #6, someone asked the professor for an
assignment involving the implementation of a feedforward neural network with
backpropagation.

This is what Yaser Abu-Mostafa answered:

> Use a neural network with one hidden layer (L=2) and d(0)=2, d(1)=2, d(2)=1
> to learn from the in.dta file and test on the out.dta file, and vice versa.

So this is my take. :-)

## Implementation Details

This implementation uses the _tanh_ as the activation function, but other
sigmoid function can be used just as easily. It's also possible to change the
number of inputs per layer.

The way the weights are updated is very similar to Stochastic Gradient Descent
(SGD), and you can change the learning rate by modifying the value for `eta`.

### Convergence Issues And Termination Criteria

This algorithm is succeptible to local minima, so try running this a few times
to get a feel about how the algorithm performs on the given data with the
current parameters.

You can tune the values for `deltat` and `maxepochs` in order to affect when
the algorithm decides to stop. An _epoch_ is counted after each and every
training example is used to process a full iteration of back propagation.
