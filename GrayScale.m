M = 64;
N = 64;
x = rand(M,N);
m = floor(255*(floor(x*4)/3));
image(m([1:4], [1:4]));
colormap(gray(256))
axis('off');

figure(2)
% number in the middle is the interval of distinct gradients
x = 1:8:256;
m = x(ones(20,1),:);
image(m);
z256 = zeros(256,1);
cmap = [ z256 z256 [1:256]' ]/256;
colormap(cmap);
axis('off')
