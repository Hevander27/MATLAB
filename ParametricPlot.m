th = linspace(0,2*3.14,40);
r = 1.1; g = 0.1;
cx = sqrt(r^2-g^2)-1; cy = g;
x = r*cos(th) + cx;
y = r*sin(th) + cy;
plot(x, y, 'r')
axis equal
grid on
hold on
z = complex(x,y);
w = z + 1./z;
plot(real(w),imag(w), 'k')