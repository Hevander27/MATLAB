function outline = edgeDetect(img,varargin)
%EDGEDETECT outlines edges of prominent features in an image
%
% Author: Hevander Da Costa
% Date: 03/24/2022
%
% Function:
%   EDGEDETECT(IMG)
%
% Purpose:
%   Takes in an image matrix and outputs a matrix of prominent feature.
%   Allows change of outline threshold factor and output of image.
%   Future interation will output the size, and perimetere of each
%   feature outline as sorted arrays. Update will also include an arry
%   holding every outline in within its own matrix
%
% Variables:
%   {Parameters} 
%   IMG: image matrix data
%   VARARGIN: accepts 'double' < 1, strictly as a second value; 
%             accepts 'display' as a second or third value 
%   {Return}
%   OUTLINE: matrix of the outline of image
%   Displays outline of objects in the orginal image
%----------------------------------------------------
%   
%

amps = uint16(img(:,:,1))+uint16(img(:,:,2))+uint16(img(:,:,3));
up = max(max(amps));                % max value in summed array
dn= min(min(amps));                 % min value in summed array
fact = 0;                           % Default factor 0


if nargin >= 2 && isa(varargin{1},'double')
    fact = varargin{1};
    if varargin{1} > 1
        error('Error. \nArgument must be less than 1.');
    end
else
    fact = 0.5;
end
                                 
thresh = uint16(dn+fact*(up-dn));   % threshold for edge of feature 
pix = amps(2:end,2:end);
pt1 = amps(1:end-1,1:end-1);
pt = amps(1:end-1, 2:end);
p1 = amps(2:end,1:end-1);
alloff = and(and((pix>thresh),(pt > thresh)),and((p1 > thresh), (pt1 > thresh)));
allon =  and(and((pix <= thresh),(pt <= thresh)),and((p1 <= thresh), (pt1 <= thresh)));

[row, col, ~]= size(img);
edges = and(not(allon),not(alloff));
layer = uint8(ones(row-1,col-1)*255);
layer(edges) = 0;
outline= layer;
outline(:,:,1) = layer;
outline(:,:,2) = layer;
outline(:,:,3) = layer;
%---Depth First search or Breath first search to find outlines---

%----------------------------------------------------------------
if length(varargin) >= 1
    if isa(varargin{1},'char')
        if strcmp('display',varargin{1})
            imshow(outline);
        else
            error('Error: Incorrect argument, please type "display".');
        end
    end
    if length(varargin) == 2
         if strcmp('display',varargin{2})
            imshow(outline);
         elseif ~strcmp('display',varargin{2})
            error('Error: Incorrect argument, please type "display".');
         end
    end
end

end

  