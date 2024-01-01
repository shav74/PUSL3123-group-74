% load the dataset
load fisheriris.mat;

% select the meas(features) as data
data = meas;

% display total number of rows
N = size(data, 1);
fprintf('total number of rows(N) : %d\n', N);
featureNames = ["sepal length", "sepal width", "petal length", "petal width"];

% for each column (sepal length, sepal width, petal length, petal width)
for i = 1:4
    featureData = data(:, i);
    
    % get mean
    meanValue = mean(featureData);
    
    % get standard deviation
    stdDeviation = std(featureData);
    
    % get max value
    maxVal = max(featureData);
    
    % get min value
    minVal = min(featureData);
    
    % get root mean square
    rmsValue = rms(featureData);
    
    % display the resultswith feature name
    fprintf('\n Feature %d - %s\n', i, featureNames(i));

    fprintf('Mean: %.3f\n', meanValue);
    fprintf('Standard deviation: %.3f\n', stdDeviation);
    fprintf('Maximum: %.3f\n', maxVal);
    fprintf('Minimum: %.3f\n', minVal);
    fprintf('Root Mean Square: %.3f\n', rmsValue);
end
