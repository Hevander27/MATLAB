clc;
clear;
nbits = 8;                           % bits of data used per sample
Fs = 20000;                          % sampling frequency, 20000 samples per second
t = 0:1/Fs:0.25;                     % time vector starts at '0' increments by 1/2000 until .25
result = input('Press a Key: ','s'); % take every user input as a character

row = [697 770 852 941];             % row frequency values
col = [1209 1336 1477];              % column frequency values
switch result
    case '#'
            x1 = sin(2*pi*row(4)*t);
            x2 = sin(2*pi*col(3)*t);
            x = x1 + x2;
            sound(x,Fs,nbits);
            X = abs(fft(x));
            L = length(X);
            f = (0:L-1)*(Fs/L);

            subplot(2, 1, 1); plot(t,x); title('Time Domain');
            axis([0 0.015, -2 2]); xlabel('t(s)');
            subplot(2, 1, 2); plot(f,X); title('Frequency Domain');
            axis([500 1700 0 2500]); xlabel('f(Hx)');
    case '*'
            y1 = sin(2*pi*row(4)*t);
            y2 = sin(2*pi*col(1)*t);
            y = y1 + y2;
            sound(y,Fs,nbits);
            Y = abs(fft(y));
            L = length(Y);
            f = (0:L-1)*(Fs/L);

            subplot(2, 1, 1); plot(t,y); title('Title Domain');
            axis([0 0.015, -2 2]); xlabel('t(s)');
            subplot(2, 1, 2); plot(f,Y); title('Frequency Domain');
            axis([500 1700 0 2000]); xlabel('f(Hx)');
            
   
            
            
    case '0'
            z1 = sin(2*pi*row(4)*t);
            z2 = sin(2*pi*col(2)*t);
            z = z1 + z2;
            sound(z,Fs,nbits);
            Z = abs(fft(z));
            L = length(Z);
            f = (0:L-1)*(Fs/L);

            subplot(2, 1, 1); plot(t,z); title('Title Domain');
            axis([0 0.015, -2 2]); xlabel('t(s)');
            subplot(2, 1, 2); plot(f,Z); title('Frequency Domain');
            axis([500 1700 0 2000]); xlabel('f(Hx)');  
    case '1'
            u1 = sin(2*pi*row(1)*t);
            u2 = sin(2*pi*col(1)*t);
            u = u1 + u2;
            sound(u,Fs,nbits);
            U = abs(fft(u));
            L = length(U);
            f = (0:L-1)*(Fs/L);

            subplot(2, 1, 1); plot(t,u); title('Time Domain');
            axis([0 0.015, -2 2]); xlabel('t(s)');
            subplot(2, 1, 2); plot(f,U); title('Frequency Domain');
            axis([500 1700 0 2000]); xlabel('f(Hx)'); 
   case '2'
            v1 = sin(2*pi*row(1)*t);
            v2 = sin(2*pi*col(2)*t);
            v = v1 + v2;
            sound(v,Fs,nbits);
            V = abs(fft(v));
            L = length(V);
            f = (0:L-1)*(Fs/L);

            subplot(2, 1, 1); plot(t,v); title('Time Domain');
            axis([0 0.015, -2 2]); xlabel('t(s)');
            subplot(2, 1, 2); plot(f,V); title('Frequency Domain');
            axis([500 1700 0 2000]); xlabel('f(Hx)'); 
   case '3'
            w1 = sin(2*pi*row(1)*t);
            w2 = sin(2*pi*col(3)*t);
            w = w1 + w2;
            sound(w,Fs,nbits);
            W = abs(fft(w));
            L = length(W);
            f = (0:L-1)*(Fs/L);

            subplot(2, 1, 1); plot(t,w); title('Time Domain');
            axis([0 0.015, -2 2]); xlabel('t(s)');
            subplot(2, 1, 2); plot(f,W); title('Frequency Domain');
            axis([500 1700 0 2000]); xlabel('f(Hx)');
    case '4'
            a1 = sin(2*pi*row(2)*t);
            a2 = sin(2*pi*col(1)*t);
            a = a1 + a2;
            sound(a,Fs,nbits); 
            A = abs(fft(a));
            L = length(A);
            f = (0:L-1)*(Fs/L);

            subplot(2, 1, 1); plot(t,a); title('Time Domain');
            axis([0 0.015, -2 2]); xlabel('t(s)');
            subplot(2, 1, 2); plot(f,A); title('Frequency Domain');
            axis([500 1700 0 2000]); xlabel('f(Hx)');
    case '5'
            b1 = sin(2*pi*row(2)*t);
            b2 = sin(2*pi*col(2)*t);
            b = b1 + b2;
            sound(b,Fs,nbits);
            B = abs(fft(b));
            L = length(B);
            f = (0:L-1)*(Fs/L);

            subplot(2, 1, 1); plot(t,b); title('Time Domain');
            axis([0 0.015, -2 2]); xlabel('t(s)');
            subplot(2, 1, 2); plot(f,B); title('Frequency Domain');
            axis([500 1700 0 2000]); xlabel('f(Hx)');
    case '6'
            c1 = sin(2*pi*row(2)*t);
            c2 = sin(2*pi*col(3)*t);
            c = c1 + c2;
            sound(c,Fs,nbits);
            C = abs(fft(c));
            L = length(C);
            f = (0:L-1)*(Fs/L);

            subplot(2, 1, 1); plot(t,c); title('Time Domain');
            axis([0 0.015, -2 2]); xlabel('t(s)');

            subplot(2, 1, 2); plot(f,C); title('Frequency Domain');
            axis([500 1700 0 2000]); xlabel('f(Hx)');    
    case '7'
            i1 = sin(2*pi*row(3)*t);
            i2 = sin(2*pi*col(1)*t);
            i = i1 + i2;
            sound(i,Fs,nbits);
            I = abs(fft(i));
            L = length(I);
            f = (0:L-1)*(Fs/L);

            subplot(2, 1, 1); plot(t,i); title('Time Domain');
            axis([0 0.015, -2 2]); xlabel('t(s)');
            subplot(2, 1, 2); plot(f,I); title('Frequency Domain');
            axis([500 1700 0 2000]); xlabel('f(Hx)');  
    case '8'
            j1 = sin(2*pi*row(3)*t);
            j2 = sin(2*pi*col(2)*t);
            j = j1 + j2;
            sound(j,Fs,nbits);
            J = abs(fft(j));
            L = length(J);
            f = (0:L-1)*(Fs/L);

            subplot(2, 1, 1); plot(t,j); title('Time Domain'); 
            axis([0 0.015, -2 2]); xlabel('t(s)');
            subplot(2, 1, 2); plot(f,J); title('Frequency Domain');
            axis([500 1700 0 2000]); xlabel('f(Hx)');
    case '9'
            k1 = sin(2*pi*row(3)*t);
            k2 = sin(2*pi*col(3)*t);
            k = k1 + k2;
            sound(k,Fs,nbits);
            K = abs(fft(k));
            L = length(k);
            f = (0:L-1)*(Fs/L);

            subplot(2, 1, 1); plot(t,k); title('Time Domain');
            axis([0 0.015, -2 2]); xlabel('t(s)');
            subplot(2, 1, 2); plot(f,K); title('Frequency Domain');
            axis([500 1700, 0 2000 ]);xlabel('f(Hz)');
    otherwise
            error('Invalid Input');
end

 
