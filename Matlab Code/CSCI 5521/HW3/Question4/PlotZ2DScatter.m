%%
% Do a 2D scatter plot for each value in Z, using different color for each
% class. Include a label in each point.
%
% The parameters received are:
% - Z (N x 3): Output from hidden units. You will not use first column,
% since it is always 1
% - y (N x 1): Predicted labels (0 to 9)
%
function PlotZ2DScatter(Z,y)
%%%% YOUR CODE STARTS HERE
Z = Z(:,2:3);
scatter(Z(:,1),Z(:,2),[],y);
%%%%
end