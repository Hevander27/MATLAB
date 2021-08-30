N = 64;
n = 0 : N-1;
w = 2 * pi /N;
x = sin (n * w) ;
% x = sin(n*w) + 5;
% x = cos(n*w) +5;
stem (x);
XX = fft (x);
pause;

m = abs (XX);
p = angle (XX);
iz = find ( abs (m < 1));
p(iz) = zeros ( size(iz));
figure;
subplot (2, 1, 1); stem (m);
subplot (2, 1, 2); stem (p);