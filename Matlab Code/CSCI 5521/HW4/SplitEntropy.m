%%
% Find the split entropy, such that y was divided in two sets y0 and y1
% according to a feature
%
% The parameters received are:
% - y0 (n_0 x 1): The labels of each datapoint in X0, such that X was divided
% in X0 and X1
% - y1 (n_1 x 1): The labels of each datapoint in X1
%
% The function should return:
% - Ip (1 x 1): The split entropy
%
function Ip = SplitEntropy(y0,y1)
%%%% YOUR CODE STARTS HERE
    [n_0,~] = size(y0);
    [n_1,~] = size(y1);
    n = n_0 + n_1;
    I_0 = NodeEntropy(y0);
    I_1 = NodeEntropy(y1);
    Ip = (n_0/n)*I_0 + (n_1/n)*I_1;
%%%% 
end

