N = 256;
n = 0:N - 1;
w = 2*pi/N;
x = 7*cos(3*n*w) + 13*sin(6*n*w);
plot(x);
% fast fourier transform
XX = fft(x);
figure(2)
stem(XX)

XX(1)/N
XX(2:10)/(N*2)
