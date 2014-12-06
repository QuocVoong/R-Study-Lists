clear all;
close all;

wavFileName = 'phoneNumber.wav';
frequencies = [1209 1336 1477 1633 697 770 852 941];
bound = 30;
filterOrder = 5;

[y, fs, nbits] = wavread(wavFileName);

% ===== epd
epdPrm=epdPrmSet(fs);
[epInSampleIndex, epInFrameIndex, soundSegment] = epdByVol(y, fs, nbits, epdPrm, 1);

% ===== filter design
fprintf('filter design ...\n');
coefA = [];
coefB = [];
figure;
for i = 1:length(frequencies)
    thisFreq = frequencies(i);
    wn = [thisFreq-bound thisFreq+bound]/(fs/2);
    [b, a] = butter(filterOrder,wn);
    coefA = [coefA;a];
    coefB = [coefB;b];
    % ===== display
    [h,w] = freqz(b,a);
    subplot(2,4,i);
    plot(w/pi*fs/2, abs(h), '.-');
    title(num2str(thisFreq));
    grid on;
end

% ===== decode
keys = [];
fprintf('decode ...\n');
for i = 1:length(soundSegment)
    figure;
    thisDigitWav = y(soundSegment(i).beginSample:soundSegment(i).endSample);
    % ===== high
    highImpuse = [];
    for j = 1:4
        d = filter(coefB(j,:),coefA(j,:),thisDigitWav);
        highImpuse = [highImpuse max(d)];
        subplot(2,4,j);
        plot(d);
        axis([-inf, inf, -1,1]);
        title(num2str(frequencies(j)));
    end
    % ===== low
    lowImpuse = [];
    for j = 1:4
        d = filter(coefB(j+4,:),coefA(j+4,:),thisDigitWav);
        lowImpuse = [lowImpuse max(d)];
        subplot(2,4,j+4);
        plot(d);
        axis([-inf, inf, -1,1]);
        title(num2str(frequencies(j+4)));
    end
    % ===== get 2 frequencies
    [m, idx] = max(highImpuse);
    freqHigh = frequencies(idx);
    [m, idx] = max(lowImpuse);
    freqLow = frequencies(idx+4);
    % ===== sum is unique ...
    k = freq2digit(freqHigh,freqLow);
    keys = [keys k];
end

fprintf('decoded phone number : %s\n',keys);