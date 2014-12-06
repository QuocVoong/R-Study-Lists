htkPrm=htkParamSet;
htkPrm.pamFile='digitMonophone.pam';
htkPrm.phoneMlfFile='digitMonophone.mlf';
htkPrm.mnlFile='digitMonophone.mnl';
htkPrm.feaCfgFile='mfcc39.cfg';
htkPrm.feaType='MFCC_E_D_A_Z';
htkPrm.feaDim=39;
htkPrm.streamWidth=[39];
disp(htkPrm)
[trainRR, testRR]=htkTrainTest(htkPrm);
fprintf('Inside test = %g%%, outside test = %g%%\n', trainRR, testRR);