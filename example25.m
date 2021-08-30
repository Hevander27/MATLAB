clear;
clc

fs = 8000; % sampling frequency
% sampling frequency should be twice as high as the highest pitch

tmax = 4;% time for recording
nbits = 16;
nchan = 1;
Recorder = audiorecorder(fs, nbits, nchan);
record(Recorder)
fprintf(1, 'Recording..\n' );
pause(tmax);
stop(Recorder);

%integer sequence
yi = getaudiodata(Recorder, 'int16');
% convert int to double for more accurarcy
y = double(yi);

% normalizing the date 
y = y/max(abs(y));
plot(y);
sound(y,fs);
sound(y,fs)
