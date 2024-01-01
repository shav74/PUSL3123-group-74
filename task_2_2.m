% load the fisheriris dataset
load fisheriris.mat

% shuffle the dataset
rng(1); % For reproducibility
shuffledIndexes = randperm(length(meas));
shuffledData = meas(shuffledIndexes,:);
shuffledTarget = species(shuffledIndexes);

% convert categories in species to numeric values
[shuffledTarget, ~] = grp2idx(shuffledTarget);

% split the data into training and testing sets
ratio = 0.6; %boundary for the split
splitBoundary = floor(ratio * length(meas));
trainData = shuffledData(1:splitBoundary,:);
trainTarget = shuffledTarget(1:splitBoundary);
testData = shuffledData(splitBoundary+1:end,:);
testTarget = shuffledTarget(splitBoundary+1:end);

% initialize hidden layer sizes as an array to loop through
hiddenLayerSizes = [10, 15, 20];

% initialize the results and test_results for each hidden layer size
results = zeros(length(hiddenLayerSizes), 1);
test_results = zeros(4,1);

% train and test the neural network for all hidden layer sizes
for i = 1:length(hiddenLayerSizes)
    % inner loop to repeat 4 times
    % selecting feedfowardnet
        
    for j = 1:4
        net = feedforwardnet(hiddenLayerSizes(i));
        % viewing the network diagram
        net = train(net, trainData', trainTarget');
        view(net)
        %round the predictions beacuse the categories are converted to
        %integers with grp2idx()
        predictions = round(net(testData'));
        accuracy = sum(predictions == testTarget') / length(testTarget);
        fprintf("accuracy for %d hidden layers test %d : %.2f%% \n", hiddenLayerSizes(i),j,accuracy*100 );
        test_results(j) = accuracy;
    end
    % inserting test avarages to the final results
    results(i) = mean(test_results);
    fprintf("average accuracy for hidden %d hidden layers : %.2f%% \n", hiddenLayerSizes(i),results(i)*100);
end

% display the final average accuracy
fprintf('Final accuracy: %.2f%%', mean(results)*100);
