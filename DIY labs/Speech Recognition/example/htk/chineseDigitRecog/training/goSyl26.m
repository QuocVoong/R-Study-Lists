htkPrm=htkParamSet;
htkPrm.pamFile='digitSyl.pam';
htkPrm.feaCfgFile='mfcc26.cfg';
htkPrm.feaType='MFCC_E_D_Z';
htkPrm.feaDim=26;
htkPrm.streamWidth=[26];
disp(htkPrm)
[trainRR, testRR]=htkTrainTest(htkPrm);
fprintf('Inside test = %g%%, outside test = %g%%\n', trainRR, testRR);