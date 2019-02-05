%%
% Train the MLP
%
% The parameters received are:
% - X_trn (N x D): Training datapoints matrix, where N is the 
% number of training data points, and D is the number of features
% - y_trn (N x 1): Vector that should contain the labels of the 
% training datapoints
% - H (1 x 1): Number of hidden units
%
% The function should return:
% - Y_pred (N x K): Output from the last Forward Propagation
% - Z (N x H+1): Matrix that contains the output from the hidden units,
% including the bias unit z0=+1
% - W (D+1 x H): Weights learned between each input unit and hidden unit
% - V (H+1 x K): Weights learned between each hidden unit and output unit
%
function [Y_pred,Z,W,V] = MLPTrain(X_trn, y_trn, H)
    
    K = 10;
    D = size(X_trn,2);
    maxiter = 1000;
    eta = 0.0005;

    rng(1); % For reproducibility
    W = -0.01 + (0.01+0.01)*rand(D+1,H);
    rng(2); % For reproducibility
    V = -0.01 + (0.01+0.01)*rand(H+1,K); % V (H+1 x K)

    % Find initial value of Y, Z and the Error function, using 
    % ForwardPropagation and ErrorFunction
    %%%% YOUR CODE STARTS HERE
    [Y_pred,Z] = ForwardPropagation(X_trn, W, V);
    E = ErrorFunction(y_trn,Y_pred);
    %%%% 
    
    % Notice: we are implementing Batch Gradient Descent, not Stochastic
    % Gradient Descent. In Batch gradient descent, we use all the samples
    % at the same time (see equations in section 11.7.3)
    for iter=1:maxiter
        
        % Find updates dW and dV, using BackwardPropagation, and update W 
        % and V
        %%%% YOUR CODE STARTS HERE
        [dW, dV] = BackwardPropagation(X_trn, y_trn, Y_pred, Z, V, eta);
        W = W + dW;
        V = V + dV;
        %%%%
        
        % Find new Y and Z, using ForwardPropagation
        % Calculate new value of error function, using ErrorFunction
        %%%% YOUR CODE STARTS HERE
        [Y_pred,Z] = ForwardPropagation(X_trn, W, V);
        E_new = ErrorFunction(y_trn,Y_pred);
        %%%%
        
        % Check convergence and stop if abs(E_new-E) <= 0.2
        %%%% YOUR CODE STARTS HERE
        if abs(E_new-E) <= 0.2
            break;
        end
        %%%%
        
    end
    
end

