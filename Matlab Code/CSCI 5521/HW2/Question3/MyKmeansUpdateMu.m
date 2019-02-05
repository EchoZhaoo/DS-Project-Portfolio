%%
% The MyKmeansUpdateMu updates mu, given the current r values
%
% The parameters received are:
% - X (N x 3): Matrix for a color image RGB, where N is the number of
% pixels. 
% - K (1 x 1): Number of clusters (number of colors in the compression)
% - r (N x K): Contains 0 or 1, where r(n,k) contains 1 if pixel n belongs to
% cluster k, otherwise 0
%
% The function should return:
% - mu (K x 3): Contains the K centroids found, representing the K colors
% learned
%
function mu = MyKmeansUpdateMu(X,K,r)
%%%% YOUR CODE STARTS HERE
    r_x = (r')*X; % K by 3
    mu = zeros(K, 3);
    r_n = sum(r)'; % K by 1
    for i = 1:3
        mu(:,i) = rdivide(r_x(:,i), r_n);
    end    
%%%%
end

