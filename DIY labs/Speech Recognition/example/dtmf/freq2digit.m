function digit = freq2digit( freqHigh, freqLow )
freqSum = freqHigh + freqLow;
switch freqSum
    case 1906
        digit = '1';
    case 2033
        digit = '2';
    case 2174
        digit = '3';
    case 2330
        digit = 'A';
    case 1979
        digit = '4';
    case 2106
        digit = '5';
    case 2247
        digit = '6';
    case 2403
        digit = 'B';
    case 2061
        digit = '7';
    case 2188
        digit = '8';
    case 2329
        digit = '9';
    case 2485
        digit = 'C';
    case 2150
        digit = '*';
    case 2277
        digit = '0';
    case 2418
        digit = '#';
    case 2574
        digit = 'D';
    otherwise
        digit = 'Z'; % unknown
end
