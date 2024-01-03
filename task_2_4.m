% load the fish iris dataset
load fisheriris.mat;

% shuffling the dataset
rng(3); % for reproducibility
shuffledIndexes = randperm(length(meas));
shuffledData = meas(shuffledIndexes,:);
shuffledTarget = species(shuffledIndexes);

% split the data into training and test sets 60:40
splitRatio = 0.6;
splitNumber = floor(splitRatio * length(meas));
trainData = shuffledData(1:splitNumber,:);
trainTarget = shuffledTarget(1:splitNumber);
testData = shuffledData(splitNumber+1:end,:);
testTarget = shuffledTarget(splitNumber+1:end);

% k values to iterate
k_values = [2, 20];
for K = k_values
    % implement KNN classifier
    model = fitcknn(trainData, trainTarget, 'NumNeighbors', K);
    
    % predicting the values
    predictedSpecies = predict(model, testData);
    
    % create and display the confution matrix
    cMat = confusionmat(testTarget, predictedSpecies);
    fprintf('Confusion Matrix for K = %d\n', K);
    disp(cMat);
    
    % calculating and diplaying the accuracy of the model
    correctPredictions = sum(strcmp(predictedSpecies, testTarget));
    accuracy = correctPredictions / length(testTarget) * 100;
    fprintf('Accuracy for K = %d : %.3f%% \n', K,accuracy);
end
