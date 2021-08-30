images = loadMNISTImages('test_set');
labels = loadMNISTLabels('test_label');

tar = csvread('train.csv',1,0);
sub= csvread('test.csv' ,1,0);

figure
colormap(gray)
for i = 1:36
    subplot(6,6,i)
    digit = reshape(images(:,i),[28,28]);
    imagesc(digit)
    title(num2str(labels(i)))
end


n = size(tar, 1);                    % number of samples in the dataset
targets  = tar(:,1);                 % 1st column is |label|
targets(targets == 0) = 10;         % use '10' to present '0'
targetsd = dummyvar(targets);       % convert label into a dummy variable
inputs = tar(:,2:end);               % the rest of columns are predictors

inputs = inputs';                   % transpose input
targets = targets';                 % transpose target
targetsd = targetsd';               % transpose dummy variable

rng(1);                             % for reproducibility
c = cvpartition(n,'Holdout',n/3);   % hold out 1/3 of the dataset

Xtrain = inputs(:, training(c));    % 2/3 of the input for training
Ytrain = targetsd(:, training(c));  % 2/3 of the target for training
Xtest = inputs(:, test(c));         % 1/3 of the input for testing
Ytest = targets(test(c));           % 1/3 of the target for testing
Ytestd = targetsd(:, test(c));      % 1/3 of the dummy variable for testing

baseHN= 5;
stepHN= 20;
maxHN = 40;



Yprob = NN3900(Xtest);             % predicts probability for each label
Yprob(:, 1:10)                       % display the first 5 columns
[~, Yprob] = max(Yprob);            % find the indices of max probabilities
sum(Ytest == Yprob)/length(Ytest); % compare the predicted vs. actual

sweep = [baseHN,stepHN:stepHN:maxHN];                 % parameter values to test
scores = zeros(length(sweep), 1);       % pre-allocation
models = cell(length(sweep), 1);        % pre-allocation
x = Xtrain;                             % inputs
t = Ytrain;                             % targets
%array = ['trainscg','traingda','traingd','trainlm'];

%for x = 1:size(array)
   % net.trainFnc = array(x);
%end

net.trainFcn = 'traingda';                  % scaled conjugate gradient
for i = 1:length(sweep)
    hiddenLayerSize = sweep(i);         % number of hidden layer neurons
    net = patternnet(hiddenLayerSize);  % pattern recognition network
    net.divideParam.trainRatio = 70/100;% 70% of data for training
    net.divideParam.valRatio = 15/100;  % 15% of data for validation
    net.divideParam.testRatio = 15/100; % 15% of data for testing
    net = train(net, x, t);             % train the network
    models{i} = net;                    % store the trained network
    p = net(Xtest);                     % predictions
    [~, p] = max(p);                    % predicted labels
    scores(i) = sum(Ytest == p) /...    % categorization accuracy
        length(Ytest);
end

figure
plot(sweep, scores, '.-')
xlabel('number of hidden neurons')
ylabel('categorization accuracy')
title('Number of hidden neurons vs. accuracy')

