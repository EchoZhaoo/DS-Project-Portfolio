%% Read training, validation and test set using ReadData
%%%% YOUR CODE STARTS HERE
[X_trn, y_trn, X_val, y_val, X_tst, y_tst] = ReadData("optdigits_train.txt", "optdigits_valid.txt", "optdigits_test.txt");
%%%% 

%% Parameter selection
thetas=[0.01,0.2,0.3,0.4,0.5,1.0,2.0];

val_errors = zeros(length(thetas),1);  % val_errors(7 x 1)

for theta_idx=1:length(thetas)
    theta = thetas(theta_idx);
    
    % generate a decision tree for the current theta value using GenerateTree
    %%%% YOUR CODE STARTS HERE
    root_node = GenerateTree(X_trn,y_trn,theta);
    %%%% 

    % make predictions for each training datapoint, calling PredictWithTree
    % for each of them. Then, find the error rate on the training set
    %%%% YOUR CODE STARTS HERE
    [n,~] = size(X_trn);
    y_pred = zeros(n,1);
    for i = 1:n
        y_pred(i,1) = PredictWithTree(root_node,X_trn(i,:));
    end
    error_rate = CalculateErrorRate(y_pred,y_trn);
    %%%%
    fprintf('(theta=%f) Training set error rate: %.4f\n', theta, error_rate);

    % make predictions for each validation datapoint, calling PredictWithTree
    % for each of them. Then, find the error rate on the validation set
    %%%% YOUR CODE STARTS HERE
    [n,~] = size(X_val);
    y_pred = zeros(n,1);
    for i = 1:n
        y_pred(i) = PredictWithTree(root_node,X_val(i,:));
    end
    error_rate = CalculateErrorRate(y_pred,y_val);
    %%%%
    fprintf('(theta=%f) Validation set error rate: %.4f\n', theta, error_rate);
    val_errors(theta_idx) = error_rate;
end

%% Test set prediction

% train a decision tree using the best theta
%%%% YOUR CODE STARTS HERE
[~, idx] = min(val_errors);
best_theta = thetas(idx);
root = GenerateTree(X_trn,y_trn,best_theta);
%%%% 

% make predictions for each test datapoint, calling PredictWithTree
% for each of them. Then, find the error rate on the test set
%%%% YOUR CODE STARTS HERE
[n,~] = size(X_tst);
y_pred = zeros(n,1);
for i = 1:n
    y_pred(i) = PredictWithTree(root,X_tst(i,:));
end
error_rate = CalculateErrorRate(y_pred,y_tst);
%%%% 
fprintf('(theta=%f) Test set error rate: %.4f\n', best_theta, error_rate);
