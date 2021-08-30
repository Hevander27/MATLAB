 FileName = 'Fountain.jpg';

[ImageMat] = imread(FileName);
[ImageHeight, ImageWidth, planes] = size(ImageMat);

y = 1:ImageHeight;
x = 1:ImageWidth;
 
redval   = double(ImageMat(y,x,1));
greenval = double(ImageMat(y,x,1));
blueval  = double(ImageMat(y,x,1));
       
ImageMat(y,x,1) = redval;
ImageMat(y,x,2) = greenval;
ImageMat(y,x,3) = blueval;

 
NewImageMatRGB8 = uint8(ImageMat);
image(NewImageMatRGB8);
set(gca, 'DataAspectRatio', [1 1 1]);
axis('off');


        