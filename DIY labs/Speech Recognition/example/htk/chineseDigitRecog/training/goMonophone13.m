htkPrm=htkParamSet;
htkPrm.pamFile='digitMonophone.pam';
htkPrm.phoneMlfFile='digitMonophone.mlf';
htkPrm.mnlFile='digitMonophone.mnl';
disp(htkPrm)
[trainRR, testRR]=htkTrainTest(htkPrm);
fprintf('Inside test = %g%%, outside test = %g%%\n', trainRR, testRR);