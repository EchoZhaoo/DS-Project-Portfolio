%%
% The ReadData function reads the Optdigits dataset
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
function [X_trn, y_trn, X_val, y_val, X_tst, y_tst] = ReadData(training_filename, validation_filename, test_filename)
%%%% YOUR CODE STARTS HERE
    trnMatrix = load(training_filename);
    X_trn = trnMatrix(:,1:end-1);
    y_trn = trnMatrix(:,end);

    valMatrix = load(validation_filename);
    X_val = valMatrix(:,1:end-1);
    y_val = valMatrix(:,end);

    tstMatrix = load(test_filename);
    X_tst = tstMatrix(:,1:end-1);
    y_tst = tstMatrix(:,end);
%%%% 
end
