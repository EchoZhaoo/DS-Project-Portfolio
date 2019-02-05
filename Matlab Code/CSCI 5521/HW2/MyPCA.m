%%
% The MyPCA function implements principal component analysis (PCA)
%
% The parameters received are:
% - X (n_trn x m): Training datapoints matrix, where n_trn is the 
% number of training data points, and m is the number of features
% - k (1 x 1): Number of principal components
%
% The function should return:
% - W (m x k): Projection matrix
% - mu (m x 1): Vector containing the mean of the samples in X
%
function [W, mu] = MyPCA(X, k)
%%%% YOUR CODE STARTS HERE
%%%% Note: You have to implement your own PCA function. You can use eig or
%%%% eigs to find the eigenvalues/eigenvectors, cov to find the
%%%% covariance matrix and mean to find the mean vector
[~, m] = size(X); % Get the row number and the column number of matrix X
mu = mean(X)';
for i = 1:m
    X_norm(:, i) = X(:,i) - mean(X(:,i)); % Matrix normalization
end
X_cov = cov(X_norm); % Get the covariance matrix
[X_Vect, X_Val] = eig(X_cov); % Get eigenvalues and corresponding eigenvectors
[~, X_Val_sorted] = sort(diag(X_Val),'descend'); % Sort eigenvalues in decreasing order
X_Vect = X_Vect(:,X_Val_sorted); % Sort eigenvectors in decreasing order
W = X_Vect(:,1:k); % Use the first k eigenvectors to create the projection matrix W
%%%%
end

