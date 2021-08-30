facets = 100;
u = linspace(0, 5, facets);
th = linspace(0, 2*pi, facets);
[uu tth] = meshgrid(u, th);

% Rotate about x-axis
subplot(1,2,1)
rr = uu.^2;
xx = uu;
yy = rr.*cos(tth);
zz = rr.*sin(tth);
surf(xx, yy, zz)
shading interp, axis tight
xlabel('x'), ylabel('y'), zlabel('z')
title('u^2 rotated about the x-axis')

% Rotate about z-axis
subplot(1, 2, 2)
rr = uu;
zz = rr.^2;
xx = rr.*cos(tth);
yy = rr.*sin(tth);
surf(xx, yy, zz);
shading interp, axis tight
xlabel('x'), ylabel('y'), zlabel('z')
title('u^2 rotated about the z-axis')