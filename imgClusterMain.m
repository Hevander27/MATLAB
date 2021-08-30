clear;clc;
A = imread('m1pic.jpg');
[row, col, xx] = size(A);
for i = 1:row
    for j = 1:col
        if(A(i,j,:) < 25)
            A(i,j,:) = 0;
        end
    end
end
figure,imshow(A);
A =im2double(A);
%disp(A);
k = 6;
imgCluster(A, k);
