%%
% The ProjectDatapoints function projects the samples in X to W 
%
% The parameters received are:
% - W (m x k): Projection matrix, where m is the number of original 
% features and k the number of features in the new space (principal
% components)
% - mu (m x 1): Vector containing the mean used when constructing W
% (which was returned by MyPCA)
% - X (n x m): Datapoints matrix, where n is the number of data points to
% be projected
%
% The function should return:
% - Z (n x k): Datapoints projected to W
%
function Z = ProjectDatapoints(W,mu,X)
%%%% YOUR CODE STARTS HERE
[n_trn,m] = size(X);% the number of column of matrix X
for i = 1:m
    X_n(:,i) = X(:,i) - ones(n_trn,1)*mu(i,1); % Matrix normalization
end
Z = X_n*W;  
%%%%
end

