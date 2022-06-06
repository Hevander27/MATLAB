function y = tempCalculate(video_Frame, roomTemp)
%TEMPCALCULATE calculates the temperature of a thermal profile
%  
% Author: Hevander Da Costa
% Date: 03/24/2022
%
% Function:
%   Y = TEMPERATURE(VIDEO_FRAME, ROOMTEMP)
%
% Purpose:
%   Takes in an image matrix and outputs a temperature value.
%   Seperates the foreground and background within the thermal 
%   image. Calls `profileDetect` to extract the profile. The 
%   background and profile are used to calculate 
%
%
% Variables:
%   {Parameters} 
%   VIDEO_FRAME: image matrix data from a camera
%   ROOMTEMP: ambient room temperature given by a thermostat      
%   {Return}
%   Y: a temperate value for the thermal profile 
%----------------------------------------------------
%   See also imgCluster, profileDetect

[imgArray, ~] = imgCluster(video_Frame,2); % call to clustering function 
foreArray = imgArray(:,:,:,1);             % saves cluster of the foreground image
backArray = imgArray(:,:,:,2);             % saves cluster of the background image
big = 57600;                               % value of image row*column

a = reshape(foreArray,big,1);              % coverts foreground matrix to big by 1 array
b = reshape(backArray,big,1);              % coverts background matrix to big by 1 array
c = cat(2,a,b);                            % concats into big by 2 array

[M,~] = max(c); [~,I] = maxk(M,2);         % checks which of the arrays have the highest max
foreGround = imgArray(:,:,:,I(1));         % saves max `I` index to foreground 
backGround = imgArray(:,:,:,I(2));         % saves min `I` index to foreground 
profile = profileDetect(foreGround,1);     % calls function that detect on the face
                                           
                                           % bottom two lines for greater 
                                           % accuracy by slower processing                                  
search1 = profile(:,:,1);                  %+profile(:,:,2)+profile(:,:,3);
search2 = backGround(:,:,1);               %+backGround(:,:,2) +backGround(:,:,3);

ampsHigh = mean(mean(quantile(nonzeros(search1),0.75)));    % mean of the top 25% of values in search1
ampsLow  = min(min(nonzeros(search2)));                     % min of value of search2
%%% function to calculate temperature                       
slope = (93-roomTemp)/(ampsHigh-ampsLow);                   
y = slope*(ampsHigh) + roomTemp;
%%%------------------------------------
end