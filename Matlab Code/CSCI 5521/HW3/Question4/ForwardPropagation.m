%%
% Implements the MLP Forward Propagation step. You can use the Sigmoid
% function that we give
%
% The parameters received are:
% - X (N x D): Training datapoints matrix, where N is the 
% number of training data points, and D is the number of features
% - W (D+1 x H): Weights between each input unit and hidden unit
% - V (H+1 x K): Weights between each hidden unit and output unit
%
% The function should return:
% - Y (N x K): Output of each output unit
% - Z (N x H+1): Output of each hidden units, including the bias unit z0=+1
%
function [Y,Z] = ForwardPropagation(X, W, V)
%%%% YOUR CODE STARTS HERE
[N ~] = size(X);
[~,K] = size(V);
bias = ones(N,1);
X = [bias X];
Z = X*W;
Z = Sigmoid(Z);
Z = [bias Z];
y_hat = transpose(transpose(V)*transpose(Z));
Y = zeros(N,K);
for i=1:N
    for j=1:K
        Y(i,j)=exp(y_hat(i,j))/sum(exp(y_hat(i,:)));
    end
end
%%%%
end

