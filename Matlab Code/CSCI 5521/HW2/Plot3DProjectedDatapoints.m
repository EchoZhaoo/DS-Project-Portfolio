%%
% The Plot3DProjectedDatapoints does a 3D plot using samples in X with 
% predicted labels
%
% The parameters received are:
% - X (n_tst x 3): Test datapoints matrix projected to W, where n_tst is the 
% number of test data points
% - y_pred (n_tst x 1): Predicted labels
%
function Plot3DProjectedDatapoints(X,y_pred)
%%%% YOUR CODE STARTS HERE
%%%% It is recommended that you use the scatter3 MATLAB function
    scatter3(X(:,1),X(:,2),X(:,3),[],y_pred);
%%%%
end

