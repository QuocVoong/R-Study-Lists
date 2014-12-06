alpha=linspace(-0.99, 0.99, 13);
N=100;

h=freqz([1 -0.95], 1, N);

h=[];
for i=1:length(alpha),
	fr=freqz([1 alpha(i)], 1, 100);
	db=10*log10(fr.*conj(fr));
	h = [h, db];
end
plot(linspace(0, 0.5, N), h);
title('Frequency response of H(z)=1+\alphaz^{-1}');
ylabel('Decibel');
xlabel('Normalized Freq');

legendStr={};
for i=1:length(alpha),
	legendStr={legendStr{:}, ['\alpha=', num2str(alpha(i))]};
end
legend(legendStr);