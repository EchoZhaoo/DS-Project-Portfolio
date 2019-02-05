%%
% The MyKmeansErrorFunction calculated the Kmeans error function
%
% The parameters received are:
% - X (N x 3): Matrix for a color image RGB, where N is the number of
% pixels. 
% - r (N x K): Contains 0 or 1, where r(n,k) contains 1 if pixel n belongs to
% cluster k, otherwise 0
% - mu (K x 3): Contains the K centroids found, representing the K colors
% learned
%
% The function should return:
% - j (1 x 1): Error function calculated using the current mu and r
%
function j = MyKmeansErrorFunction(X,r,mu)
%%%% YOUR CODE STARTS HERE
    [N, K] = size(r);
    j = 0;
    for a = 1:N
        for b = 1:K
            dist = X(a,:)-mu(b,:);
            j = j + r(a, b)*(dist*dist.');
        end 
    end
%%%%
end

