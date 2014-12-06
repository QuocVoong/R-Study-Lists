function playmidi(midi, timeUnit)
%PLAYMIDI 利用音效卡來播放 midi 音樂格式的發音程式
%	用法：
%	playmidi(midi, timeUnit)
%	其中 midi 是一個向量，格式為 [semitone, duration, semitone, duration .........]
%	timeUnit 則是上述 duration 所用的時間單位，預設是 1/64 秒（以配合 CBMR 辨識系統）
%
%	範例：
%	playmidi([69 1 70 1 71 1], 1)       
%	此聲音為 do re me ......      每個音間隔為 1 秒
%
%	亦可直接輸入 playmidi，就可聽到播放「哭砂」的音樂。

%	Roger Jang, 20010204

if nargin==0, selfdemo; return; end
if nargin<2, timeUnit = 1/64; end

% The time unit used in playmidimex is 1/1000 second.
midi = double(midi);
midi(2:2:end) = midi(2:2:end)*timeUnit*1000;
playmidimex(double(midi));	% 名揚的發音程式，使用 PC 喇叭
%playmidi2mex(double(midi));	% 雯妮的發音程式，使用音效卡

function selfdemo
% 播放「哭砂」的前兩句
midi = [55 23 55 23 55 23 55 23 57 23 55 35 0 9 57 23 60 69 0 18 64 69 0 18 62 23 62 23 62 23 62 12 60 12 64 23 60 35 0 9 57 12 55 12 55 127];
fprintf('播放「哭砂」的前兩句 ...\n');
feval(mfilename, midi, 1/64);
