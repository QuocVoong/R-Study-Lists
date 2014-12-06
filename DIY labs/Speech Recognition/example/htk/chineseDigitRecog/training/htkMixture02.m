htkPrm=htkParamSet;
htkPrm.feaCfgFile='mfcc26.cfg';
htkPrm.feaType='MFCC_E_D_Z';
htkPrm.feaDim=26;
htkPrm.streamWidth=[26];

maxMixNum=8;
for i=1:maxMixNum
	htkPrm.mixtureNum=i;
	fprintf('====== %d/%d\n', i, maxMixNum);
	[trainRR(i), testRR(i)]=htkTrainTest(htkPrm);
end

plot(1:maxMixNum, trainRR, 'o-', 1:maxMixNum, testRR, 'o-');
xlabel('No. of mixtures'); ylabel('Recog. rate (%)');
legend('Inside test', 'Outside test');