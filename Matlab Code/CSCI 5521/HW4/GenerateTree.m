%%
% Generate a decision tree node using X and y. This function is also used
% recursively for each tree branch, after splitting X and y
%
% The parameters received are:
% - X (n x m): where n is the number of datapoints, and m the number of
% features. If this is the root node, X contains all the datapoints.
% Otherwise, n is the number of datapoints split by parent node
% - y (n x 1): The label of each datapoint in X
%
% The function should return:
% - node (1 data structre): Data structure that represents a node. Contains
% two children (child0 and child1), the feature used to split the node
% (when internal node), and the class label (when leaf)
%
function node = GenerateTree(X,y,theta)

    % auxiliar data structure
    node = [];
    node.child0 = []; % will contain a child branch for feature=0
    node.child1 = []; % will contain a child branch for feature=1
    node.feature = []; % will contain the feature used to split this node
    node.class = []; % will contain the predicted class, when the node is a leaf

    % check the node entropy using NodeEntropy
    % if the entropy is smaller than theta, set the "node.class" with the
    % class that occurs with higher frequency in X and return. 
    % It means that the node is a leaf
    % you can set the class using, for example:
    % node.class = 5;
    %%%% YOUR CODE STARTS HERE
    
    I = NodeEntropy(y);
    if I <  theta
        count = zeros(10,1);
        [n,m] = size(X);
        for j = 1:m
            for i = 1:n
                if y(i) == j - 1
                    count(j) = count(j) + 1;
                end 
            end
        end
        [~,class] = max(count);
        node.class = class - 1;
        return
    %%
    % if ...
        %
        % return
        
    %%%% 
    
    % else (not leaf)
    % find the feature that will be used to split the non-leaf, using
    % SplitAttribute.
    % set the feature number to the 'feature' attribute of 'node'
    %%%% YOUR CODE STARTS HERE
    else
        bestf = SplitAttribute(X,y);
        node.feature = bestf;
    %%%%
    
    % split X into X0 and X1 and y into y0 and y1, according to the values 
    % of the selected feature. 
    % Then, call GenerateTree twice. Call once using X0 and y0, and once using
    % X1 and y1
    % set the returned nodes to node.child0 and node.child1
    %%%% YOUR CODE STARTS HERE
        [n,~] = size(X);
        n_0 = 0;
        n_1 = 0;
        
        for i = 1:n
            if X(i,bestf) == 0
                n_0 = n_0 + 1;
                X0(n_0,:) = X(i,:);
                y0(n_0) = y(i);
            else 
                if X(i,bestf) == 1
                    n_1 = n_1 + 1;
                    X1(n_1,:) = X(i,:);
                    y1(n_1) = y(i);
                end
            end
        end
        node.child0 = GenerateTree(X0,transpose(y0),theta);
        node.child1 = GenerateTree(X1,transpose(y1),theta);
    %%%% 
    end
end

