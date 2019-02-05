%%
% The MyKMeans performs the Kmeans algorithm
%
% The parameters received are:
% - X (N x 3): Matrix for a color image RGB, where N is the number of
% pixels. 
% - K (1 x 1): Number of clusters (number of colors in the compression)
%
% The function should return:
% - r (N x K): Contains 0 or 1, where r(n,k) contains 1 if pixel n belongs to
% cluster k, otherwise 0
% - mu (K x 3): Contains the K centroids found, representing the K colors
% learned
% - J (2*iter x 1): Error function value calculated after every r-update
% and mu-update. If MyKmeans converges in iter iterations, the vectors has
% 2*iter values
%
function [r,mu,J] = MyKMeans(X,K)
%%%% Note: You have to implement your own KMeans function, using this template.

    max_iter = 100;
    
    % initial mu
    N = size(X,1); % nrow 
    m_idx = randperm(N); % m_idx: vector 1 by N
    mu = X(m_idx(1:K),:); % <-- mu starts with random rows of X, mu: K by 3
    for iter = 1:max_iter
        
        %% r update
        % update r, using MyKmeansUpdateR
        %%%% YOUR CODE STARTS HERE
        r = MyKmeansUpdateR(X,K,mu);
        %%%%
        
        % calculate error function, using current r and mu
        %%%% YOUR CODE STARTS HERE
        J(2*iter-1,1) = MyKmeansErrorFunction(X,r,mu);
        %%%%
        
        %% mu update
        % update mu, using MyKmeansUpdateMu
        %%%% YOUR CODE STARTS HERE
        mu = MyKmeansUpdateMu(X,K,r);
        %%%%
        
        % calculate error function, using current r and mu
        %%%% YOUR CODE STARTS HERE
        J(2*iter,1) = MyKmeansErrorFunction(X,r,mu);
        %%%%
        
        %% check convergence
        % check convergence by checking if the the error function decreased
        % less than 1e-6 from the previous iteration. Break loop if
        % converged
        %%%% YOUR CODE STARTS HERE
        if (J(2*iter-1,1) - J(2*iter,1)) < 1e-6
            break;
        end
        %%%%
        
    end

%%%%
end

