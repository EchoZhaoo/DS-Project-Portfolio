%%
% The MyKmeansUpdateR updates r, given the current mu values
%
% The parameters received are:
% - X (N x 3): Matrix for a color image RGB, where N is the number of
% pixels. 
% - K (1 x 1): Number of clusters (number of colors in the compression)
% - mu (K x 3): Contains the K centroids found, representing the K colors
% learned
%
% The function should return:
% - r (N x K): Contains 0 or 1, where r(n,k) contains 1 if pixel n belongs to
% cluster k, otherwise 0
%
function r = MyKmeansUpdateR(X,K,mu)
%%%% YOUR CODE STARTS HERE
    N = size(X,1);
    r = zeros(N,K);
    for i = 1:N
        min_dist = pdist2(X(i,:), mu(1,:), 'squaredeuclidean');
        Nclass = 1;
        for j = 2:K
            dist = pdist2(X(i,:), mu(j,:), 'squaredeuclidean'); 
            if dist < min_dist
                min_dist = dist;
                Nclass = j;
            end
        end
        r(i,Nclass) = 1;
    end    
%%%%
end

