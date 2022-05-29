function y = tempCalculate(video_Frame, roomTemp)

[imgArray, ~] = imgCluster(video_Frame,2);
foreArray = imgArray(:,:,:,1);
backArray = imgArray(:,:,:,2);
big = 57600;
a = reshape(foreArray,big,1);
b = reshape(backArray,big,1);
c = cat(2,a,b);
[M,~] = max(c); [~,I] = maxk(M,2);
foreGround = imgArray(:,:,:,I(1));
backGround = imgArray(:,:,:,I(2));
profile = profileDetect(foreGround,1);
search1 = profile(:,:,1);%+profile(:,:,2)+profile(:,:,3);
search2 = backGround(:,:,1);%+backGround(:,:,2) +backGround(:,:,3);
ampsHigh = mean(mean(quantile(nonzeros(search1),0.75)));
ampsLow  = min(min(nonzeros(search2)));
slope = (93-roomTemp)/(ampsHigh-ampsLow);
y = slope*(ampsHigh) + roomTemp;
end