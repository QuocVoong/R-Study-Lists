function y = recSound(filename, duration, fs)
%RECSOUND Sound recording
%	Usage: y = RECSOUND(filename, duration, fs);

if nargin<3, fs=11025; end
if nargin<2, duration=8; end
if nargin<1, filename='test.wav'; end

% ===== Recording
fprintf('Hit return to start %g-second of recording...\n', duration);
pause;
fprintf('Start recording ...\n');
y = wavrecord(duration*fs, fs, 'uint8');
fprintf('Finish %g-second of recording.\n', duration);
y = double(y);		% Convert from a uint8 to double array
y = (y-128)/128;	% Make y zero mean and unity maximum 

% ====== Save to a wave file
wavwrite(y, fs, 8, filename);
fprintf('Save the microphone input to "%s".\n', filename);
