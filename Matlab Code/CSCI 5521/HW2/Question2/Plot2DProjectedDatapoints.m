%%
% The Plot2DProjectedDatapoints does a 2D plot using samples in X with 
% predicted labels
%
% The parameters received are:
% - X (n_tst x 2): Test datapoints matrix projected to W, where n_tst is the 
% number of test data points
% - y_pred (n_tst x 1): Predicted labels
%
function Plot2DProjectedDatapoints(X,y_pred)
%%%% YOUR CODE STARTS HERE
%%%% It is recommended that you use the scatter MATLAB function
scatter(X(:,1),X(:,2),[],y_pred);
%%%%
end

