%%
% Find the best feature to be split, using SplitEntropy
%
% The parameters received are:
% - X (n x m): where n is the number of datapoints, and m the number of
% features. 
% - y (n x 1): The label of each datapoint in X
%
% The function should return:
% - bestf (1 x 1): The index of the best feature to split
%
function bestf = SplitAttribute(X,y)
%%%% YOUR CODE STARTS HERE
    [n,m] = size(X);
    I = zeros(m,1);
    for i = 1:m
        n_0 = 0;
        n_1 = 0;
        y0 = zeros;
        y1 = zeros;
        for j = 1:n
            if X(j,i) == 0
                n_0 = n_0 + 1;
                y0(n_0) = y(j);
            else
                n_1 = n_1 + 1;
                y1(n_1) = y(j);
            end
        end
        I(i) = SplitEntropy(transpose(y0),transpose(y1));
    end
    [~,bestf] = min(I);
%%%% 
end

