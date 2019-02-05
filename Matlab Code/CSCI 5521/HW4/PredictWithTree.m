%%
% Makes prediction for a datapoint
%
% The parameters received are:
% - root_node (1 data structure): The root of the learned decision tree
% - x (1 x m): One datapoint, where m is the number of features
%
% The function should return:
% - y_pred (1 x 1): The prediction for x
%
function y_pred = PredictWithTree(root_node,x)
%%%% YOUR CODE STARTS HERE
    while(isempty(root_node.class)) % not leaf node
        feature = root_node.feature;
        if x(1,feature) == 0 
            root_node = root_node.child0;
        else  % x(feature) == 1
            root_node = root_node.child1;
        end
    end
    % leaf node
    y_pred = root_node.class;        
%%%% 
end

