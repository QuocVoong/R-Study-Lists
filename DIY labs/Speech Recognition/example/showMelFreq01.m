linFreq=0:8000;
melFreq=lin2melFreq(linFreq);
plot(linFreq, melFreq);
xlabel('Frequency');
ylabel('Mel-frequency');
title('Frequency to mel-frequency curve');
axis equal tight