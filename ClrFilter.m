clear;
clc;
close all;

FileName = 'starry_night.jpg';
[ImageMat, cmap] = imread(FileName);
[ImageHeight, ImageWidth, NmColorPlanes] = size(ImageMat);
image(ImageMat);
set(gca, 'DataAspectRatio', [1 1 1]);
axis off
pause;


% retrive RGB values and set them in seperate arrays
redMat = ImageMat(:,:,1);
greenMat = ImageMat(:,:,2);
blueMat = ImageMat(:,:,3);

% Change all red green and blue to the average of RGB values
temp = uint8((0.8*ImageMat(:,:,1) + 0.8*ImageMat(:,:,2) + 0.8*ImageMat(:,:,3))/3);
redMat = temp;
greenMat = temp;
blueMat = temp;

% Input number to a number 1 to 6
% Number retrieves color data corresponding to Color string array
disp("Press Any Key")
Color = ["Red","Green","Blue","Blue&Green","Red&Green","Red&Blue"];
clrNum = input('Input number from 1 to 6: ');

switch(clrNum)
    case 1
        blueMat = 0;
        greenMat = 0;
        disp(Color(1));
    case 2
        redMat = 0;
        greenMat = 0;
        disp(Color(2));
    case 3
        redMat = 0;
        blueMat = 0;
        disp(Color(3));
    case 4
        redMat = 0;
        disp(Color(4));
    case 5
        blueMat = 0;
        disp(Color(5));
    case 6
        greenMat = 0;
        disp(Color(6))
end



NewImageMat = zeros(size(ImageMat));
NewImageMat(:,:,1) = redMat;
NewImageMat(:,:,2) = greenMat;
NewImageMat(:,:,3) = blueMat;

% convert to 8-bit usigned
NewImageMatRGB8 = uint8(NewImageMat);

% display NewImage
image(NewImageMatRGB8);
set(gca, 'DataAspectRatio', [1 1 1]);
axis('off');
