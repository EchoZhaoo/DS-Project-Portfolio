%% Read Optdigits dataset
% read data: call ReadOptdigitsDataset
%%%% YOUR CODE STARTS HERE
[X_trn, y_trn, X_tst, y_tst] = ReadOptdigitsDataset('optdigits_train.txt','optdigits_test.txt');
%%%%

%% 2a) KNN using all the features

% We will be using k=1, 2, 3 or 4
for k=[1,2,3,4]
    % classify the test set using k nearest neighbors (KNN)
    % call PerformKNN
    %%%% YOUR CODE STARTS HERE
    [y_tst_pred, error_rate] = PerformKNN(X_trn, y_trn, X_tst, y_tst, k);
    %%%%
    disp(strcat('All features, k=', num2str(k), ' error rate: ', num2str(error_rate,3)));
end

%% 2b) Apply PCA with 2 principal components and do KNN again

% do PCA using 2 principal components, using the MyPCA function
%%%% YOUR CODE STARTS HERE
[W_2, mu_2] = MyPCA(X_trn, 2);
%%%%

% project both training and test set using the projection matrix learned
% using MyPCA, using ProjectDatapoints (you may call ProjectDatapoints
% twice)
%%%% YOUR CODE STARTS HERE
Z_trn_2 = ProjectDatapoints(W_2, mu_2, X_trn);
Z_tst_2 = ProjectDatapoints(W_2, mu_2, X_tst);
figure
Plot2DProjectedDatapoints(Z_trn_2, y_trn);
figure
Plot2DProjectedDatapoints(Z_tst_2, y_tst);
%%%%

% We will be using k=1, 2, 3 or 4
%figure % <-- this line will create a new window to plot. You can change/remove if you want
for k=[1,2,3,4]
    % classify the test set (in the projected dimension) using k nearest neighbors (KNN)
    % call PerformKNN
    %%%% YOUR CODE STARTS HERE
    [y_tst_pred_2, error_rate] = PerformKNN(Z_trn_2, y_trn, Z_tst_2, y_tst, k);
    %%%%
    disp(strcat('2 principal components, k=', num2str(k), ' error rate: ', num2str(error_rate,3)));
    
    subplot(2,2,k); % <--- this line will create a subplot in the window created by "figure". You can change/remove if you want
    % plot projected test datapoints with different colors, according to
    % the predicted class, using Plot2DProjectedDatapoints
    %%%% YOUR CODE STARTS HERE
    Plot2DProjectedDatapoints(Z_tst_2, y_tst_pred_2);
    %%%%
end

%% 2c) Apply PCA with 3 principal components and do KNN again

% do PCA using 3 principal components, using the MyPCA function
%%%% YOUR CODE STARTS HERE
[W_3, mu_3] = MyPCA(X_trn, 3);
%%%%

% project both training and test set using the projection matrix learned
% using MyPCA, using ProjectDatapoints (you may call ProjectDatapoints
% twice)
%%%% YOUR CODE STARTS HERE
Z_trn_3 = ProjectDatapoints(W_3, mu_3, X_trn);
Z_tst_3 = ProjectDatapoints(W_3, mu_3, X_tst);
figure
Plot2DProjectedDatapoints(Z_trn_3, y_trn);
figure
Plot2DProjectedDatapoints(Z_tst_3, y_tst);
%%%%

% We will be using k=1, 2, 3 or 4
for k=[1,2,3,4]
    % classify the test set (in the projected dimension) using k nearest neighbors (KNN)
    % call PerformKNN
    %%%% YOUR CODE STARTS HERE
    [y_tst_pred_3, error_rate] = PerformKNN(Z_trn_3, y_trn, Z_tst_3, y_tst, k);
    %%%%
    disp(strcat('3 principal components, k=', num2str(k), ' error rate: ', num2str(error_rate,3)));
    
    subplot(2,2,k); % <--- this line will create a subplot in the window created by "figure". You can change/remove if you want
    % plot projected test datapoints with different colors, according to
    % the predicted class, using Plot3DProjectedDatapoints
    %%%% YOUR CODE STARTS HERE
    Plot3DProjectedDatapoints(Z_tst_3, y_tst_pred_3);
    %%%%
end