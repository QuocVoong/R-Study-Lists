% Åª¤J modelName.txt
modelListFile='output\modelName.txt';
models = textread(modelListFile,'%s','delimiter','\n','whitespace','');
% Åª¤J hcompv.hmm
hmmFile='output\hcompv.hmm';
fid=fopen(hmmFile, 'r');
contents=fread(fid, inf, 'char');
contents=char(contents');
fclose(fid);
% ¼g¥X macro.0
outFile='output\macro.0';
fid=fopen(outFile, 'w');
source='~h "hcompv.hmm"';
for i=1:length(models)
	target=sprintf('~h "%s"', models{i});
	x=strrep(contents, source, target);
	fprintf(fid, '%s', x);
end
fclose(fid);