% Get the RR when feature dim. and mixture no. are changing

htkPrm=htkParamSet;
maxMixNum=8;

for i=1:maxMixNum
	htkPrm.mixtureNum=i;
	fprintf('====== %d/%d\n', i, maxMixNum);
	[trainRR(i,1), testRR(i,1)]=htkTrainTest(htkPrm);
end

htkPrm.feaCfgFile='mfcc26.cfg';
htkPrm.feaType='MFCC_E_D_Z';
htkPrm.feaDim=26;
htkPrm.streamWidth=[26];
for i=1:maxMixNum
	htkPrm.mixtureNum=i;
	fprintf('====== %d/%d\n', i, maxMixNum);
	[trainRR(i,2), testRR(i,2)]=htkTrainTest(htkPrm);
end

htkPrm.feaCfgFile='mfcc39.cfg';
htkPrm.feaType='MFCC_E_D_A_Z';
htkPrm.feaDim=39;
htkPrm.streamWidth=[39];
for i=1:maxMixNum
	htkPrm.mixtureNum=i;
	fprintf('====== %d/%d\n', i, maxMixNum);
	[trainRR(i,3), testRR(i,3)]=htkTrainTest(htkPrm);
end

plot(	1:maxMixNum, trainRR(:,1), '^-b', 1:maxMixNum, testRR(:,1), 'o-b', ...
	1:maxMixNum, trainRR(:,2), '^-g', 1:maxMixNum, testRR(:,2), 'o-g', ...
	1:maxMixNum, trainRR(:,3), '^-r', 1:maxMixNum, testRR(:,3), 'o-r');
xlabel('No. of mixtures'); ylabel('Recog. rate (%)');
legend('13D, Inside test', '13D, Outside Test', '26D, Inside Test', '26D, Outside test', '39D, Inside test', '39D, Outside test', 'Location', 'BestOutside');