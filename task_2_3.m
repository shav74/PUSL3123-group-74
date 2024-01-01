% get the values only as data
values = load('kmeansdata.mat');
data = values.X;

% initializing a zeros matrix to store mean silhouette values
silh_values = zeros(3,1);

for k = 3:5
    figure;
    plot(data(:,1),data(:,2),'.');
    title(['K value = ', num2str(k)]);
    % calling kmeans
    [idx,C,sumd]=kmeans(data,k);

    [silh,h] = silhouette(data,idx,'sqEuclidean');
    title(['Number of clusters = ' int2str(k)]);
    xlabel 'Silhouette Value ';
    ylabel 'Cluster';

    %inserting the mean silhouette value to calculate the optimal k value
    %later with max(silh_values)
    silh_values(k-2) = mean(silh);

    figure;
    % plotting cluster in a scatter plot as we have multiple culusters
    gscatter(data(:,1), data(:,2), idx);
    hold on;
    % marking centroids with x in the scatter plot
    plot(C(:,1), C(:,2), 'wx');
    hold off;
    title(['Clusters and Centroids for K = ' int2str(k)]);
    hold off;
end

%getting only the index ang ignoring the max value to display
[~ , best_k_value] = max(silh_values);

% recorrecting the value by adding +2 beacuse [1=>3, 2=>4, 3=>5]
fprintf("best k value is %d", best_k_value+2);

