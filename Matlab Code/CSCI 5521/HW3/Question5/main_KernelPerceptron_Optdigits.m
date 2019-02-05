%% Digits 4 and 9
% Load Optdigits dataset with digits 4 and 9 using ReadOptdigitsData
%%%% YOUR CODE STARTS HERE
[X_trn_49, y_trn_49, X_tst_49, y_tst_49] = ReadOptdigitsData('optdigits49_train.txt', 'optdigits49_test.txt');
%%%%

sigma = 1; %% <----- change to the sigma (RBF parameter) you want to use

% Run the Kernel Perceptron using KernelPerceptron on the training set
%%%% YOUR CODE STARTS HERE
alphas_trn_49 = KernelPerceptron(X_trn_49,y_trn_49,sigma);
%%%%

% Predict the label for the training set, using MakePredictions, and then
% calculate the error rate on the training set
%%%% YOUR CODE STARTS HERE
y_pred_trn_49 = MakePredictions(X_trn_49, y_trn_49, X_trn_49, alphas_trn_49,sigma);
error_rate = ErrorRate(y_pred_trn_49,y_trn_49);
%%%%
disp(strcat('Digits 4 and 9 training set error rate: ', num2str(error_rate)));

% Predict the label for the test set, using MakePredictions, and then
% calculate the error rate on the test set
%%%% YOUR CODE STARTS HERE
y_pred_tst_49 = MakePredictions(X_trn_49, y_trn_49, X_tst_49, alphas_trn_49,sigma);
error_rate = ErrorRate(y_pred_tst_49,y_tst_49);
%%%%
disp(strcat('Digits 4 and 9 test set error rate: ', num2str(error_rate)));

%% Digits 7 and 9
% Load Optdigits dataset with digits 7 and 9 using ReadOptdigitsData
%%%% YOUR CODE STARTS HERE
[X_trn_79, y_trn_79, X_tst_79, y_tst_79] = ReadOptdigitsData('optdigits79_train.txt', 'optdigits79_test.txt');
%%%%

sigma = 2; %% <----- change to the sigma (RBF parameter) you want to use

% Run the Kernel Perceptron using KernelPerceptron on the training set
%%%% YOUR CODE STARTS HERE
alphas_trn_79 = KernelPerceptron(X_trn_79,y_trn_79,sigma);
%%%%

% Predict the label for the training set, using MakePredictions, and then
% calculate the error rate on the training set
%%%% YOUR CODE STARTS HERE
y_pred_trn_79 = MakePredictions(X_trn_79, y_trn_79, X_trn_79, alphas_trn_79,sigma);
error_rate = ErrorRate(y_pred_trn_79,y_trn_79);
%%%%
disp(strcat('Digits 7 and 9 training set error rate: ', num2str(error_rate)));

% Predict the label for the test set, using MakePredictions, and then
% calculate the error rate on the test set
%%%% YOUR CODE STARTS HERE
y_pred_tst_79 = MakePredictions(X_trn_79, y_trn_79, X_tst_79, alphas_trn_79,sigma);
error_rate = ErrorRate(y_pred_tst_79,y_tst_79);
%%%%
disp(strcat('Digits 7 and 9 test set error rate: ', num2str(error_rate)));









