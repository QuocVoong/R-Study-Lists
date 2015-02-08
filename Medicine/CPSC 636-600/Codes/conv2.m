function [Out] = conv2 (In1, In2, mode)

% conv2( a, b, mode )    : mode == 'same'
%	conv2
%	after matlab conv2
%	version 3
%	20000720
%	Marius Schamschula <marius@caos.aamu.edu>
%	CAOS/AAMU

%	mode 'same' is implemented

if (strcmp ('same', mode))
	if (size (In1) > size (In2))
		Intp = zeros (size (In1));
		c1 = columns (In1);
		c2 = columns (In2);
		r1 = rows (In1);
		r2 = rows (In2);
		Intp (floor(r1/2)-floor(r2/2):floor(r1/2)-floor(r2/2)+r2-1, floor(c1/2)-floor(c2/2):floor(c1/2)-floor(c2/2)+c2-1) = In2;
		In2 = Intp;
	elseif (size (In1) < size (In2))
		Intp = zeros (size (In2));
		c1 = columns (In1);
		c2 = columns (In2);
		r1 = rows (In1);
		r2 = rows (In2);
		Intp (floor(r2/2)-floor(r1/2):floor(r2/2)-floor(r1/2)+r1-1, floor(c2/2)-floor(c1/2):floor(c2/2)-floor(c1/2)+c1-1) = In1;
		In1 = Intp;
	end
	In1 = fftshift (In1);
	In2 = fftshift (In2);
	F1 = fft2 (In1);
	F2 = fft2 (In2);
	Out = ifft2 (F1.*F2);
	Out = ifftshift (Out);
else
	printf ('Usage conv2 (array, kernel, mode)\nWhere mode is a string\nCurrently the only allowed mode is same');
end
