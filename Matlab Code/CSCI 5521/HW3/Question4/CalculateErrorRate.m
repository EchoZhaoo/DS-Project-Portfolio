%%
% Calculates the error rate (percentage of wrongly classified samples)
%
% The parameters received are:
% - Y_pred (N x K): Output of each output unit
% - y_label (N x 1): True labels of each data point, where N is the number
% of data points
%
% The function should return:
% - error_rate (1 x 1): The error rate (between 0 and 1)
%
function error_rate = CalculateErrorRate(Y_pred,y_label)
%%%% YOUR CODE STARTS HERE
N = size(Y_pred,1);
n = 0;
for i = 1:N
    [~,b] = max(Y_pred(i,:));
    if y_label(i) ~= b-1
        n = n + 1;
    end
end
error_rate =  n/N;  

%%%% 
end