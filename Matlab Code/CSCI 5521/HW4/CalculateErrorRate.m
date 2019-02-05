%%
% y (n x 1): The true label of each datapoint in X
% y_pred (n x 1): The predicted label of each datapoint in X
%
% error_rate (1 x 1)
function error_rate = CalculateErrorRate(y_pred,y)
%%%% YOUR CODE STARTS HERE
[n,~] = size(y);
count = 0;
for i = 1:n
    if y(i) ~= y_pred(i)
        count = count + 1;
    end
end
error_rate = count/n;
%%%% 
end