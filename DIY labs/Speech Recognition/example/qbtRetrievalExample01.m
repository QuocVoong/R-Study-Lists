fprintf('Reading the song database...\n');
songDb=songDbRead('childSong');
songNum=length(songDb);
fprintf('Process the song database...\n');
for i=1:songNum
	songDb(i).ioi=double(songDb(i).track(2:2:end))/64;	% In terms of sec.
end

fprintf('Process the query file...\n');
waveFile='tapping.wav';
[y, fs, nbits, opts, cueLabel]=wavReadInt(waveFile);
wObj=waveFile2obj(waveFile);
odPrm=odPrmSet;
onset=odByVol(wObj, odPrm);
queryIoi=diff(onset)/fs;	% In terms of sec.

fprintf('Compare the query with the database...\n');
distance=zeros(songNum, 1);
for i=1:songNum
	distance(i)=ioiDistance(queryIoi, songDb(i).ioi);
end

[sortedDistance, index]=sort(distance);
fprintf('Top-10 results:\n');
for i=1:10
	fprintf('%d: songName=%s, distance=%f\n', i, songDb(index(i)).songName, distance(index(i)));
end