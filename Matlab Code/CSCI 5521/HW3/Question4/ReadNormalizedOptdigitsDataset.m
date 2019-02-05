%%
% The ReadNormalizedOptdigitsDataset function reads the Optdigits. Data
% should be first centered using the mean of the training set, and then
% normalized dividing by the standard deviation of the training set, so 
% that x_norm = (x-mean_trn)/(sigma_trn^2)
%
% The parameters received are:
% - training_filename: string containing the training data file path
% - validation_filename: string containing the validation data file path
% - test_filename: string containing the test data file path
%
% The function should return:
% - X_trn (n_trn x m): Training datapoints matrix, where n_trn is the 
% number of training data points, and m is the number of features
% - y_trn (n_trn x 1): Vector that should contain the labels of the 
% training_filename file (last column)
% - X_val (n_val x m): Validation datapoints matrix, where n_val is the 
% number of validation data points, and m is the number of features
% - y_val (n_val x 1): Vector that should contain the labels of the 
% validation_filename file (last column)
% - X_tst (n_tst x m): Test datapoints matrix, where n_tst is the number of 
% test data points, and m is the number of features
% - y_tst (n_tst x 1) Vector that should contain the labels of the 
% test_filename file (last column)
%
function [X_trn_norm, y_trn, X_val_norm, y_val, X_tst_norm, y_tst] = ReadNormalizedOptdigitsDataset(training_filename, validation_filename, test_filename)
%%%% YOUR CODE STARTS HERE
% For training data
trn_matrix = load(training_filename);
X_trn = trn_matrix(:, 1:end-1);
y_trn = trn_matrix(:, end);

mean_trn = mean(X_trn);
var_trn = var(X_trn);
zeroidx = find(~var_trn);
var_trn(zeroidx) = randperm(numel(zeroidx));

X_trn_norm = (X_trn-mean_trn)./var_trn;

% For validation data
val_matrix = load(validation_filename);
X_val = val_matrix(:, 1:end-1);
X_val_norm = (X_val-mean_trn)./var_trn;
y_val = val_matrix(:, end);

%For testing data
tst_matrix = load(test_filename);
X_tst = tst_matrix(:, 1:end-1);
X_tst_norm = (X_tst-mean_trn)./var_trn;
y_tst = tst_matrix(:, end);

%%%%
end

