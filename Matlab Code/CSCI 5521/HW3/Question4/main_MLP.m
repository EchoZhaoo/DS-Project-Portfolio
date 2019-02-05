%% 4a) 

% read data: call ReadNormalizedOptdigitsDataset
%%%% YOUR CODE STARTS HERE
[X_trn_norm, y_trn, X_val_norm, y_val, X_tst_norm, y_tst] = ReadNormalizedOptdigitsDataset('optdigits_train.txt', 'optdigits_valid.txt', 'optdigits_test.txt');
%%%%

Hs = [4,8,12,16,20,24];
training_error = zeros(length(Hs),1);
validation_error = zeros(length(Hs),1);

% check training and validation error for each option of H
for i=1:length(Hs)
    H = Hs(i);

    % train MLP using current H using MLPTrain
    %%%% YOUR CODE STARTS HERE
    [Y_trn_pred,~,W,V] = MLPTrain(X_trn_norm, y_trn, H);
    %%%%

    % calculate error rate for Y predicted to the training set using CalculateErrorRate
    %%%% YOUR CODE STARTS HERE
    training_error(i) = CalculateErrorRate(Y_trn_pred,y_trn);
    %%%%

    fprintf('Training set error rate when H=%d: %f\n', H, training_error(i));
    
    % Predict Y for the validation set, using ForwardPropagation
    %%%% YOUR CODE STARTS HERE
    [Y_val_pred,~] = ForwardPropagation(X_val_norm, W, V);
    %%%%

    % calculate error rate for Y predicted to the validation set using CalculateErrorRate
    %%%% YOUR CODE STARTS HERE
    validation_error(i) = CalculateErrorRate(Y_val_pred,y_val);
    %%%%
    
    fprintf('Validation set error rate when H=%d: %f\n', H, validation_error(i));
    
end

% Plot training and validation error using PlotTrainingValidationError
%%%% YOUR CODE STARTS HERE
PlotTrainingValidationError(Hs,training_error,validation_error);
%%%% 

% train MLP using the best number of hidden units MLPTrain
%%%% YOUR CODE STARTS HERE
[~,idx] = min(transpose(validation_error));
[~,~,W,V] = MLPTrain(X_tst_norm, y_tst, Hs(idx)); 
%%%%

% Predict Y for the test set, using ForwardPropagation
%%%% YOUR CODE STARTS HERE
[Y_tst_pred,~] = ForwardPropagation(X_tst_norm, W, V);
%%%%

% calculate error rate for Y predicted to the test set using CalculateErrorRate
%%%% YOUR CODE STARTS HERE
test_error = CalculateErrorRate(Y_tst_pred,y_tst);
%%%%

fprintf('Test set error rate when H=%d: %f\n', Hs(idx), test_error);

%% 4b) 

% Train the MLP with 2 hidden units, using MLPTrain
%%%% YOUR CODE STARTS HERE
[y_trn_pred_2,Z_trn_2,W,V] = MLPTrain(X_trn_norm, y_trn, 2);
[~, y_trn_label_2] = max(transpose(y_trn_pred_2)); % y_trn_label_2: 1xN
y_trn_label_2 = transpose(y_trn_label_2) - 1;  % y_trn_label_2: Nx1
%%%%

% Predict Y for the validation and test set, using ForwardPropagation
%%%% YOUR CODE STARTS HERE
%%%% Predict Y for the validation set
[y_val_pred_2,Z_val_2] = ForwardPropagation(X_val_norm, W, V);
[~, y_val_label_2] = max(transpose(y_val_pred_2)); % y_val_label_2: 1xN
y_val_label_2 = transpose(y_val_label_2) - 1;  % y_val_label_2: Nx1

%%%% Predict Y for the test set
[y_tst_pred_2,Z_tst_2] = ForwardPropagation(X_tst_norm, W, V);
[~, y_tst_label_2] = max(transpose(y_tst_pred_2)); % y_tst_label_2: 1xN
y_tst_label_2 = transpose(y_tst_label_2) - 1;  % y_tst_label_2: Nx1
%%%%

% Do a 2D scatter showing Z for the training, validation and test set in
% separate figures, using PlotZ2DScatter for each figure
%%%% YOUR CODE STARTS HERE
figure
PlotZ2DScatter(Z_trn_2,y_trn_label_2);
figure
PlotZ2DScatter(Z_val_2,y_val_label_2);
figure
PlotZ2DScatter(Z_tst_2,y_tst_label_2);
%%%% 

%% 4c) 

% Train the MLP with 3 hidden units, using MLPTrain
%%%% YOUR CODE STARTS HERE
[y_trn_pred_3,Z_trn_3,W,V] = MLPTrain(X_trn_norm, y_trn, 3);
[~, y_trn_label_3] = max(transpose(y_trn_pred_3)); % y_trn_label_3: 1xN
y_trn_label_3 = transpose(y_trn_label_3) - 1;  % y_trn_label_3: Nx1
%%%%

% Predict Y for the validation and test set, using ForwardPropagation
%%%% YOUR CODE STARTS HERE
%%%% Predict Y for the validation set
[y_val_pred_3,Z_val_3] = ForwardPropagation(X_val_norm, W, V);
[~, y_val_label_3] = max(transpose(y_val_pred_3)); % y_val_label_3: 1xN
y_val_label_3 = transpose(y_val_label_3) - 1;  % y_val_label_3: Nx1

%%%% Predict Y for the test set
[y_tst_pred_3,Z_tst_3] = ForwardPropagation(X_tst_norm, W, V);
[~, y_tst_label_3] = max(transpose(y_tst_pred_3)); % y_tst_label_2: 1xN
y_tst_label_3 = transpose(y_tst_label_3) - 1;  % y_tst_label_2: Nx1
%%%%

% Do a 3D scatter showing Z for the training, validation and test set in
% separate figures, using PlotZ3DScatter for each figure
%%%% YOUR CODE STARTS HERE
figure
PlotZ3DScatter(Z_trn_3,y_trn_label_3);
figure
PlotZ3DScatter(Z_val_3,y_val_label_3);
figure
PlotZ3DScatter(Z_tst_3,y_tst_label_3);
%%%% 
