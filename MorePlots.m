a = (1:10).^2
plot(a)
% produces new figure(#)
figure(2)
b = (-10:10).^2
plot(b);

figure(3)
t = -10:10;
b = t.^2
plot(t,b);

figure(4)
x1 = 0 : 0.1 : 2*pi; y1 = sin(x1);
x2 = pi/2 : 0.1 : 3*pi; y2 = cos(x2);
plot(x1,y1,x2,y2)

figure(5)
% 'r' for red line 'k' for black ':' for doted line 
plot(x1,y1, 'r', x2,y2,'k:')

figure(6)
% 'm--o' formate is magenta dash line with circle markers
plot(t,b, 'm--o')

% help plot for more options
% hold on all subsequent plots will be plot on same axis
% hold off will replace all subsequent plots
figure(7)
plot(x1,y1,x2,y2)
grid on
title('A Sine and Cosine Plot')
ylabel('the value of the sine or cosine')
xlabel('the argument of sine and cosine')
legend('sine', 'cosine')
axis([-2 12 -1.5 1.5])

