htkPrm=htkParamSet;
htkPrm.pamFile='digitMonophone.pam';
htkPrm.phoneMlfFile='digitMonophone.mlf';
htkPrm.mnlFile='digitMonophone.mnl';
htkPrm.feaCfgFile='mfcc26.cfg';
htkPrm.feaType='MFCC_E_D_Z';
htkPrm.feaDim=26;
htkPrm.streamWidth=[26];
disp(htkPrm)
[trainRR, testRR]=htkTrainTest(htkPrm);
fprintf('Inside test = %g%%, outside test = %g%%\n', trainRR, testRR);