images = loadMNISTImages('training_set');
labels = loadMNISTLabels('training_label');

labels = labels';                               % transpose
labels(labels==0)=10;                           % dummyvar function doesn´t take zeroes
labels=dummyvar(labels);                        
labels = reshape(labels,10,60000);

figure                                          % initialize figure
colormap(gray)                                  % set to grayscale
for i = 1:36                                    % preview first 36 samples
    subplot(6,6,i)                              % plot them in 6 x 6 grid
    digit = reshape(images(:, i), [28,28]);     % row = 28 x 28 image
    imagesc(digit)                              % show the image
    title(num2str(labels(i)))                   % show the label
end

x = images;
t = labels;
trainFcn = 'trainscg';                  % use scaled conjugate gradient for training

hiddenLayerSize = 100;                          
net = patternnet(hiddenLayerSize);      % create Pattern Recognition Network

net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio   = 15/100;
net.divideParam.testRatio  = 15/100;
net.performFcn = 'crossentropy';

[net,tr] = train(net,x,t);

net = models{end};                      % restore the last model
W1 = zeros(hiddenLayerSize, 28*28);     % pre-allocation
W1(:, x1_step1_keep) = net.IW{1};       % reconstruct the full matrix
figure                                  % plot images
colormap(gray)                          % set to grayscale
for i = 1:25                            % preview first 25 samples
    subplot(5,5,i)                      % plot them in 6 x 6 grid
    digit = reshape(W1(i,:), [28,28])'; % row = 28 x 28 image
    imagesc(digit)                      % show the image
end
