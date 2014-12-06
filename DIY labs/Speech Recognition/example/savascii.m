function savascii(mat, filename)
% SAVEASCII Save a matrix as an ascii file

fid = fopen(filename, 'w');
for i = 1:size(mat,1),
	fprintf(fid, '%d ', mat(i, :));
	fprintf(fid, '\n');
end
fclose(fid);