[y, fs]=wavread('welcome.wav');
sound(y, fs);		% Playback of the original sound
fprintf('Press any key to continue...\n'); pause
soundsc(y, fs);		% Playback of the sound after scaling