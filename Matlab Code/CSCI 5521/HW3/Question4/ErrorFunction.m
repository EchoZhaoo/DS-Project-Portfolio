%%
% Calculates the error function according to the current predictions
%
% The parameters received are:
% - y_label (N x 1): True labels of each data point, where N is the number
% of data points
% - Y_pred (N x K): Output of each output unit, where K=10 (0 to 9)
%
% The function should return:
% - E (1 x 1): The value of the error function
%
function E = ErrorFunction(y_label,Y_pred)
%%%% YOUR CODE STARTS HERE
[N,K] = size(Y_pred);
r = zeros(N, K); % r: N x K
for i = 1:N
    k = y_label(i) + 1;
    r(i,k) = 1;
end

E = -1*sum(sum(r.*log(Y_pred)),2);

%%%%
end

