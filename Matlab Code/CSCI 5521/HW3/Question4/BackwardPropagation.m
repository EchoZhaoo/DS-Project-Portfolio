%%
% Implements the MLP Backward Propagation step
%
% The parameters received are:
% - X (N x D): Training datapoints matrix, where N is the 
% number of training data points, and D is the number of features
% - y_label (N x 1): True labels of each data point
% - Y_pred (N x K): Output of each output unit
% - Z (N x H+1): Matrix that contains the output from the hidden units,
% including the bias unit z0=+1
% - V (H+1 x K): Weights between each hidden unit and output unit
% - eta (1 x 1): The learning rate
%
% The function should return:
% - dW (D+1 x H): Updates for the weights in W
% - dV (H+1 x K): Updates for the weights in V
%
function [dW, dV] = BackwardPropagation(X, y_label, Y_pred, Z, V, eta)
%%%% YOUR CODE STARTS HERE
[N,K] = size(Y_pred);
r = zeros(N, K); % r: N x K
for i = 1:N
    k = y_label(i) + 1;
    r(i,k) = 1;
end
dV = transpose(eta*transpose(r-Y_pred)*Z);

V = V(2:end, :); % V:(H x K)
Z = Z(:, 2:end); % Z:(N x H)
a = ones(N, 1);
X = [a X]; % X: N x D+1
temp = (r-Y_pred)*transpose(V);
dW = eta*transpose((temp.*Z).*(1-Z))*X;
dW = transpose(dW);

%%%%% 
end

