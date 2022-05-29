clear;
clc;
load CNNet;
testFile = 'training_set';
testLabelFile = 'training_label';
testImgs = loadMNISTImages(testFile);
rawLabels = loadMNISTLabels(testLabelFile);
testLabels = zeros(10,10000);
testImages = reshape(testImgs,28,28,10000);
testImgs = zeros(28,28,1,10000);
testImgs(:,:,1,:) = testImages(:,:,:);
output = classify(CNNet,testImgs);
count = 0;
res = double(output)-1;
for x = 1:10000
    if(res(x) == rawLabels(x))
        count = count + 1;
    end
end
percent = count/100;
disp(percent+"%")