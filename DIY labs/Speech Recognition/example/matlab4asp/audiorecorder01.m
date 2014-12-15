fs=16000;		% Sampling rate (�����W�v)
nbits=16;
nChannels=1;
duration=3;		% Recording duration (�����ɶ�)
arObj=audiorecorder(fs, nbits, nChannels);
fprintf('Press any key to start %g seconds of recording...', duration); pause
fprintf('Recording...');
recordblocking(arObj, duration);
fprintf('Finished recording.\n');
fprintf('Press any key to play the recording...'); pause; fprintf('\n');
play(arObj);
fprintf('Plotting the waveform...\n');
y=getaudiodata(arObj);	% Get audio sample data
plot(y);		% Plot the waveform