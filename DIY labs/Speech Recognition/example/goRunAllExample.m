addMyPath;
clear all; close all; more off

allDir=dir;
dirList=allDir([allDir.isdir]);
dirList(1:2)=[];	% Get rid of '.' and '..'
dirNum=length(dirList);

for i=1:dirNum
	fprintf('%d/%d: dir=%s\n', i, dirNum, dirList(i).name);
	cd(dirList(i).name);
	goWriteOutputFile;
	cd ..
end
