%%
% Calculate the entropy
%
% The parameters received are:
% - y (n x 1): Labels of n datapoints
%
% The function should return:
% - I (1 x 1): The entropy
%
function I = NodeEntropy(y)
%%%% YOUR CODE STARTS HERE
    [n,~] = size(y);
    count = zeros(10,1);
    I = 0;
    for j = 1:10
        for i = 1:n
            if y(i) == j - 1
                count(j) = count(j) + 1;
            end
        end
        if count(j) ~= 0
            I = I - (count(j)/n)*log2(count(j)/n);
        end
    end  
%%%%
end

