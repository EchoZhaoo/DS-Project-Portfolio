%%
% Predict the labels (+1 or -1) for the points received in X
%
% The parameters received are:
% - X_trn (N_trn x D): Training data points, where N_trn is the number of
% points, and D the number of features
% - y_trn (N x 1): True labels of thr training set (-1 or +1)
% - X (N x D): Data points that you want to classify
% - alphas (N_trn x D): Dual coefficients that you learned for the training
% datapoints using KernelPerceptron
% - sigma (1 x 1): RBF parameter
%
% The function should return y_pred (N x 1) containing -1 or +1 for each of
% the datapoints in X
%
function y_pred = MakePredictions(X_trn, y_trn, X, alphas,sigma)
%%%% YOUR CODE STARTS HERE
[N_trn,~] = size(X_trn);
[N,~] = size(X);
K = zeros(N_trn,N);
for i = 1:N_trn
    for j = 1:N
        K(i,j) = RBF(X_trn(i,:),X(j,:),sigma);
    end
end

y_pred = zeros(N,1);
for i = 1:N
    y_pred(i) = sign(sum(alphas.*y_trn.*K(:,i))); % N x 1
end

%%%%
end

