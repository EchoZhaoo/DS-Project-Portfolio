%%
% The PerformKNN call MATLAB functions that perform KNN
%
% The parameters received are:
% - X_trn (n_trn x m): Training datapoints matrix, where n_trn is the 
% number of training data points, and m is the number of features
% - y_trn (n_trn x 1): Vector containing the labels of the training set
% - X_tst (n_tst x m): Test datapoints matrix, where n_tst is the number of 
% test data points
% - y_tst (n_tst x 1): Vector containing the labels of the test set
% - k (1 x 1): Number of neighbors
%
% The function should return:
% - y_tst_pred (n_tst x 1): Vector containing predicted labels for the 
% the test set
% - error_rate (1 x 1): Error rate (percentage of wrongly classified test
% samples, between 0 and 1)
%
function [y_tst_pred, error_rate] = PerformKNN(X_trn, y_trn, X_tst, y_tst, k)
%%%% YOUR CODE STARTS HERE
%%%% Note: You are allowed to use MATLAB functions such as fitcknn and predict
Mdl = fitcknn(X_trn, y_trn, 'NumNeighbors', k); % Get a KNN classification model
y_tst_pred = predict(Mdl, X_tst); % Get the predicted labels
[~, error_rate] = symerr(y_tst, y_tst_pred);
%%%%
end

