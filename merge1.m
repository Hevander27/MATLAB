% sound samples of the same timeduration; http://www.philharmonia.co.uk/explore/sound_samples
[a1,fs1] = audioread('cello_A3_1_forte_arco-normal.mp3',[10000 20000]);
[a, fs ] = audioread('saxophone_A3_1_forte_normal.mp3',[10000 20000]);
[a2,fs2] = audioread('trumpet_A3_1_forte_normal.mp3',[10000 20000]);
[a3,fs3] = audioread('violin_A3_1_forte_arco-normal.mp3',[10000 20000]);

figure(1)
plot(a);

figure(2)
N1 = length(a);
% graph : https://dadorran.wordpress.com/2014/02/17/plot_freq_spectrum/
X1_mags = abs(fft(a));%fourier transform
bin_vals = 0 : N1-1; 
fax_Hz = bin_vals* fs/N1;
N_2 = ceil(N1/2);
plot(fax_Hz(1:N_2), X1_mags(1:N_2))
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('(Cello) Single-sided Magnitude spectrum (Hertz)');
axis([0 2500, 0 500])

sound(a,fs);
f = (0: N1-1)*(fs/N1);
% minpeakheight controls how many frequency values will be given
%[peak_amp, peak_loc] = findpeaks(X1_mags,'Minpeakheight',20);
%freq = f(peak_loc);
%peak_freq = freq(freq<2500)
%peak_height = peak_amp(freq<2500);
%hold on
% frequency values, must be normalized to nyquist frequency for
%"buttorworth" filter
%str = num2str(int32(peak_freq))


pause

%figure(3)
plot(a1)

figure(4)
N3 = length(a1);
X2_mags = abs(fft(a1));
bin_vals = [0 : N3-1];
fax_Hz = bin_vals* fs1/N3;
N_4 = ceil(N3/2);
plot(fax_Hz(1:N_4), X2_mags(1:N_4))
xlabel('Frequency (Hz)')
ylabel('Magnitude');
title('(Saxophone)Single-sided Magnitude spectrum (Hertz)');
axis([0 2500, 0 300])
sound(a1,fs1);
%f = (0: N3-1)*(fs/N3);
%[peak_amp, peak_loc] = findpeaks(X2_mags,'Minpeakheight',15);
%freq = f(peak_loc);
%peak_freq = freq(freq<2500)
%peak_height = peak_amp(freq<2500);
%hold on
%str = num2str(int32(peak_freq))

pause;

figure(5)
plot(a2)
figure(6)
N5 = length(a2);
X3_mags = abs(fft(a2));
bin_vals = [0 : N5-1];
fax_Hz = bin_vals* fs2/N5;
N_6 = ceil(N5/2);
plot(fax_Hz(1:N_6), X3_mags(1:N_6))
xlabel('Frequency (Hz)')
ylabel('Magnitude');
title('(Trumpet)Single-sided Magnitude spectrum (Hertz)');
axis([0 1000, 0 400])
sound(a2,fs2);
%f = (0: N5-1)*(fs/N5);
%[peak_amp, peak_loc] = findpeaks(X1_mags,'Minpeakheight',10);
%freq = f(peak_loc);
%peak_freq = freq(freq<1000)
%peak_height = peak_amp(freq<1000);
%hold on
%str = num2str(int32(peak_freq))


pause;

figure(7)
plot(a3)
figure(8)
N7 = length(a3);
X4_mags = abs(fft(a3));
bin_vals = [0 : N7-1];
fax_Hz = bin_vals* fs3/N7;
N_8 = ceil(N7/2);
plot(fax_Hz(1:N_8), X4_mags(1:N_8))
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('(Violin)Single-sided Magnitude spectrum (Hertz)');
axis([0 1000, 0 400])
sound(a3, fs3);
%f = (0: N7-1)*(fs/N7);
%[peak_amp, peak_loc] = findpeaks(X1_mags,'Minpeakheight',10)
%freq = f(peak_loc)
%peak_freq = freq(freq<1000)
%peak_height = peak_amp(freq<1000)
%hold on
%str = num2str(int32(peak_freq))


pause;

% combining four wave forms
audioplayer(a,  fs);
audioplayer(a1, fs1);
audioplayer(a2, fs2);
audioplayer(a3, fs3);


lenA  = size(a ,1);
lenA1 = size(a1,1);
lenA2 = size(a2,1);
lenA3 = size(a3,1);

len = max(lenA, lenA1);
S = zeros(len,size(a,2));
S(1:lenA,:) = a;                 %cello
S(1:lenA1,:) = S(1:lenA1,:) + a1;% saxophone
S(1:lenA2,:) = S(1:lenA2,:) + a2;% trumpet
S(1:lenA3,:) = S(1:lenA3,:) + a3;% violin
maxVal = max(abs(S(:)));
S = S/maxVal;

%sound(S,44100);

figure(9)
plot(S)
figure(10)
N9 = length(S);
X5_mags = abs(fft(S));
bin_vals = [0 : N9-1];
fax_Hz = bin_vals* 44100/N9;
N_10 = ceil(N9/2);
plot(fax_Hz(1:N_10), X5_mags(1:N_10))
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('(Combo)Single-sided Magnitude spectrum (Hertz)');
axis([0 1000, 0 1400])

pause

% filtering combined wave form for desired wave form
isolate = input('Select an instrument: ','s');
switch isolate
    
    case 'Cello'
        [b,a] = butter(15,[0.05 .7 ],'bandpass');
    
        S_filtered = filter(b,a, S);

        figure(11)
        plot(S_filtered,'r')
        title('Filtered Signal - Using Second Order Butterworth')
        xlabel('Samples');
        ylabel('Amplitude')
        sound(S_filtered,44100)
    case 'Saxophone'
        
        [b,a] = butter(15,[0.04 .6 ],'bandpass');
       
        S_filtered = filter(b,a, S);

        figure(11)
        plot(S_filtered,'r')
        title('Filtered Signal - Using Second Order Butterworth')
        xlabel('Samples');
        ylabel('Amplitude')
        sound(S_filtered,44100)
     
    case 'Trumpet'
  
        [b,a] = butter(15,[0.2 .65 ],'bandpass');

        S_filtered = filter(b,a, S);

        figure(11)
        plot(S_filtered,'r')
        title('Filtered Signal - Using Second Order Butterworth')
        xlabel('Samples');
        ylabel('Amplitude')
        sound(S_filtered,44100)
        
    case 'Violin'
        [b,a] = butter(15,[0.042 .888 ],'bandpass');
 
        S_filtered = filter(b,a, S);

        figure(11)
        plot(S_filtered,'r')
        title('Filtered Signal - Using Second Order Butterworth')
        xlabel('Samples');
        ylabel('Amplitude')
        sound(S_filtered,44100) 
        
    otherwise
        error('Invalid Input');
end