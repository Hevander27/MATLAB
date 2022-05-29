clear;clc;
imgFile = 'training_set';
labelFile = 'training_label';
imgs = loadMNISTImages(imgFile);
trainLabels = loadMNISTLabels(labelFile);
labels = reshape(trainLabels,1,60000);
img = reshape(imgs,28,28,60000);
img4d = zeros(28,28,1,60000);
img4d(:,:,1,:) = img(:,:,:);
labels = categorical(labels);
layers = [
    imageInputLayer([28 28 1])
    convolution2dLayer(3,8,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    convolution2dLayer(3,16,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,32,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    fullyConnectedLayer(10)
    softmaxLayer
    classificationLayer];
options = trainingOptions('adam', ...
    'MaxEpochs',2,...
    'InitialLearnRate',1e-4, ...
    'Verbose',false, ...
    'Plots','training-progress');
CNNet = trainNetwork(img4d,labels,layers,options);
save CNNet;
