function profile = profileDetect(foreGround,thresh)
%PROFILEDETECT outlines edges of prominent features in an image
%
% Author: Hevander Da Costa
% Date: 03/29/2022
%
% Function:
%   PROFILE = PROFILEDETECT(FOREGOUND, THRESH)
%
% Purpose:
%   Takes in an image matrix and threshold value. Detects  
%   a face in the image matrix and outputs a box containing
%   only the profile.
%
% Variables:
%   {Parameters} 
%   FOREGROUND: Image matrix data
%   THRESH: Threshold for face detection. Increasing this 
%           threshold may help suppress false detections by
%           requiring that the target object be detected times.
%   {Return}
%   PROFILE: matrix containing the detected face with a black
%            background
%
% See also vision.CascadeObjectDetector, MergeTheshold


[row, col,~] = size(foreGround);
profile = zeros(row, col);

FaceDetect = vision.CascadeObjectDetector; 
FaceDetect.MergeThreshold = thresh ;
box = step(FaceDetect, foreGround);

for i = 1 : size(box, 1) 
  profile = imcrop(foreGround, box(i, :)); 
end

end