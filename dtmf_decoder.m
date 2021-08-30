
function dtmf_decoder(tone)

    load(tone)
    l = length(y);
    fs = 8000;
    freq_nyquist = fs*(.5);

    % row frequencies are below 1000, column frequencies are above 1000dtmf_
     
    % low pass filter
    [b,a] = butter(15,(1000/freq_nyquist),'low');

    % high pass filter
    [b1,a1] = butter(15,(1000/freq_nyquist), 'High' );
    
    % filter out low frequecies
    y_filter1 = filter(b,a,y);

    %filter out high frequencies
    y_filter2 = filter(b1,a1,y);

    % absolute frequency of filtered sample
    f1 = abs(fft(y_filter1));
    f2 = abs(fft(y_filter2));


    % https://dadorran.wordpress.com/2014/02/17/plot_freq_spectrum/
    X_mags = abs(fft(y_filter1));
    bin_vals = [0 : l-1];
    fax_Hz = bin_vals*fs/l;
    l_2 = ceil(l/2);
    plot(fax_Hz(1:l_2), X_mags(1:l_2))
    xlabel('Frequency (Hz)')    
    ylabel('Magnitude');
    title('Single-sided Magnitude spectrum (Hertz)');
    axis tight

    figure(2)
    X_mags1 = abs(fft(y_filter2));
    bin_vals = [0 : l-1];
    fax_Hz = bin_vals*fs/l;
    l_2 = ceil(l/2);
    plot(fax_Hz(1:l_2), X_mags1(1:l_2))
    xlabel('Frequency (Hz)')
    ylabel('Magnitude');
    title('Single-sided Magnitude spectrum (Hertz)');
    axis tight

    [max_x1,index1] = max(f1)
    [max_x2,index2] = max(f2)





    if  (index1 <= 710 && index2 <= 1220)
        disp('1 was pressed')    
    
    elseif (index1 <= 710 && index2 <= 1350)
        disp('2 was pressed')
        
    elseif  (index1 <= 710 && index2 <= 1500)
        disp('3 was pressed')
            
    elseif  (index1 <= 780 && index1 <= 1220)
        disp('4 was pressed')
        
    elseif  (index1 <= 780 && index2 <= 1350)
        disp('5 was pressed')
        
    elseif  (index1 <= 780 && index2 <= 1500)
        disp('6 was pressed')
    
    elseif  (index1 <= 870 && index1 <= 1220)
        disp('7 was pressed')
        
    elseif  (index1 <= 870 && index2 <= 1350)       
        disp('8 was pressed')    
        
    elseif   (index1 <= 870 && index2 <= 1500)       
       disp('9 was pressed')
       
    elseif  (index1 <= 950 && index2 <= 1350)
       disp('0 was pressed')
    end
end
 


