
fprintf('I.1: Generate output directories...\n');
mkdir('output');
mkdir('output/feature');
mkdir('output/hmm');

fprintf('I.2: Generate digitSyl.mnl and digitSylPhone.mlf\n');
fid=fopen('output\syl2phone.scp', 'w'); fprintf(fid, 'EX'); fclose(fid);
cmd='HLEd -n output\digitSyl.mnl -d digitSyl.pam -l * -i output\digitSylPhone.mlf output\syl2phone.scp digitSyl.mlf';
dos(cmd);

fprintf('I.3: Generate wav2fea.scp¡G'); tic;
wavDir='..\waveFile';
waveFiles=recursiveFileList(wavDir, 'wav');
outFile='output\wav2fea.scp';
fid=fopen(outFile, 'w');
for i=1:length(waveFiles)
	wavePath=strrep(waveFiles(i).path, '/', '\');
	[a,b,c,d]=fileparts(wavePath);
	fprintf(fid, '%s\t%s\r\n', wavePath, ['output\feature\', b, '.fea']);
end
fclose(fid);
fprintf('%f sec\n', toc);

fprintf('I.4: Use HCopy.exe for acoustic feature extraction: '); tic;
cmd='HCopy -C mfcc.cfg -S output\wav2fea.scp';
dos(cmd);
fprintf('%f sec\n', toc);

fprintf('II.1: Generate file listings for training and test sets in trainFea.scp and testFea.scp, respectively: '); tic;
outFile='output\trainFea.scp';
fid=fopen(outFile, 'w');
for i=1:460
	wavePath=strrep(waveFiles(i).path, '/', '\');
	[a,b,c,d]=fileparts(wavePath);
	fprintf(fid, '%s\r\n', ['output\feature\', b, '.fea']);
end
fclose(fid);
outFile='output\testFea.scp';
fid=fopen(outFile, 'w');
for i=461:length(waveFiles)
	wavePath=strrep(waveFiles(i).path, '/', '\');
	[a,b,c,d]=fileparts(wavePath);
	fprintf(fid, '%s\r\n', ['output\feature\', b, '.fea']);
end
fclose(fid);
fprintf('%f sec\n', toc);

fprintf('II.2: Generate HMM template file template.hmm\n');
feaType='MFCC_E';
feaDim=13;
outFile='output\template.hmm';
stateNum=3;
mixtureNum=[1];
streamWidth=[13];
genTemplateHmmFile(feaType, feaDim, stateNum, outFile, mixtureNum, streamWidth);

fprintf('II.3: Populate template.hmm to create hcompv.hmm\n');
cmd='HCompV -m -o hcompv.hmm -M output -I output\digitSylPhone.mlf -S output\trainFea.scp output\template.hmm';
dos(cmd);

fprintf('II.4: Duplicate hcompv.hmm to have macro.init'); tic;
% Read digitSyl.mnl
modelListFile='output\digitSyl.mnl';
models = textread(modelListFile,'%s','delimiter','\n','whitespace','');
% Read hcompv.hmm
hmmFile='output\hcompv.hmm';
fid=fopen(hmmFile, 'r');
contents=fread(fid, inf, 'char');
contents=char(contents');
fclose(fid);
% Write macro.init
outFile='output\macro.init';
fid=fopen(outFile, 'w');
source='~h "hcompv.hmm"';
for i=1:length(models)
	target=sprintf('~h "%s"', models{i});
	x=strrep(contents, source, target);
	fprintf(fid, '%s', x);
end
fclose(fid);
fprintf('%f sec\n', toc);

fprintf('II.5: Create more Gaussian components to have macro.0\n');
fid=fopen('output\mxup.scp', 'w'); fprintf(fid, 'MU 3 {*.state[2-4].mix}'); fclose(fid);
copyfile('output/macro.init', 'output/hmm/macro.0');
cmd='HHEd -H output\hmm\macro.0 output\mxup.scp output\digitSyl.mnl';
dos(cmd);

fprintf('II.6: Generate macro.1~macro.5 via EM\n');
emCount=5;
for i=1:emCount
	sourceMacro=['output\hmm\macro.', int2str(i-1)];
	targetMacro=['output\hmm\macro.', int2str(i)];
	fprintf('%d/%d: Generating %s...\n', i, emCount, targetMacro);
	copyfile(sourceMacro, targetMacro);
	cmd=sprintf('HERest -H %s -I output\\digitSylPhone.mlf -S output\\trainFea.scp output\\digitSyl.mnl', targetMacro);
	dos(cmd);
end

fprintf('III.1: Use digit.grammar to create digit.net\n');
cmd='Hparse digit.grammar output\digit.net';
dos(cmd);

fprintf('III.2: Recognition rates for both inside/outside tests\n');
fprintf('\tOutside test: Generating result_test.mlf\n');
cmd=sprintf('HVite -H %s -l * -i output\\result_test.mlf -w output\\digit.net -S output\\testFea.scp digitSyl.pam output\\digitSyl.mnl', targetMacro);
dos(cmd);
fprintf('\tInside test: Generating result_train.mlf\n');
cmd=sprintf('HVite -H %s -l * -i output\\result_train.mlf -w output\\digit.net -S output\\trainFea.scp digitSyl.pam output\\digitSyl.mnl', targetMacro);
dos(cmd);

fprintf('III.3: Generate confusion matrices for both inside/outside tests\n');
fprintf('\tGenerate confusion matrix of outside test\n');
dos('findstr /v "sil" digitSyl.mlf > output\\answer.mlf');
dos('findstr /v "sil" output\\result_test.mlf > output\\result_test_no_sil.mlf');
dos('HResults -p -I output\\answer.mlf digitSyl.pam output\\result_test_no_sil.mlf > output\\outsideTest.txt');
type output\outsideTest.txt
fprintf('\tGenerate confusion matrix of inside test\n');
dos('findstr /v "sil" output\\result_train.mlf > output\\result_train_no_sil.mlf');
dos('HResults -p -I output\\answer.mlf digitSyl.pam output\\result_train_no_sil.mlf > output\\insideTest.txt');
type output\insideTest.txt