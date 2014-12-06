% This example demonstrates the pair-wise conjugate of DFT (此範例展示實數訊號之 DFT 係數的共軛性)

N=64;			% Length of vector
x=randn(N, 1);
z=fft(x);
plot(z, 'o'); grid on
%compass(z);
% Connect conjugate pairs (將上下對稱的共軛點連起來)
for i=2:N/2+1
	twoPoint=z([i, N-i+2]);
	line(real(twoPoint), imag(twoPoint), 'color', 'r');
end