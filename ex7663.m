N = 64;
n = 0:N - 1;
w = 2*pi/N;
% orginal function
x = cos(n*w) + 5;
stem(x);

% fast fourier transform
XX = fft(x);
figure(2)
stem(XX)

XX(1)/N
XX(2:4)/(N*2)
