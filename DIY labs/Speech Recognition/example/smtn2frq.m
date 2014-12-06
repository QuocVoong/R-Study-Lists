function freq = smtn2frq(smtn)
% SMTN2FRQ Semitone to frequency conversion
freq = 440*2.^((smtn-69)/12);
