%%
% Plot data with decision boundary
%
% The parameters received are:
% - X (N x D): Samples, where N is the number of samples, and D the number
% of features
% - y (N x 1): True labels (-1 or +1)
% - alphas (N x 1): Learned dual parameters
% - sigma (1 x 1): RBF parameter
%
function PlotDataWithDecisionBoundary(X,y,alphas,sigma)
%%% YOUR CODE STARTS HERE
[N ~] = size(X);
p = 1;
q = 1;
for x_axis = -2.3:0.046:2.3
    p = 1;
    for y_axis = -2.3:0.046:2.3
        sum = 0;
        for i = 1:N
            sum = sum + alphas(i)*y(i)*RBF(X(i,:),[x_axis,y_axis],sigma);
        end
        if sum <= 0
            y_pred(q,p) = -1;
        else
            y_pred(q,p) = 1;
        end
        p = p + 1;    
    end
    q = q + 1;
end 
% 
% x_axis = -3.0:0.05:3.0; % 1x101
% y_axis = -3.0:0.05:3.0; % 1x101
% [x_axis, y_axis] = meshgrid(x_axis,y_axis);
% contour(x_axis, y_axis, y_pred);
% j = 1;
% i = 1;
% for x_axis = -2.3:0.01:2.3
%         j = 1;
%         for y_axis = -2.5:0.1:2.5
%             sum_y = 0;
%             for q = 1:size(X,1)
%                 sum_y = sum_y + alphas(q)*y(q)*RBF(X(q,:),[x_axis,y_axis],sigma);
%             end
%             if sum_y < 0
%                 Y(i,j) = -1;
%             else
%                 Y(i,j) = 1;
%             end
%             j = j + 1;    
%         end
%         i = i + 1;
% end
%     x = -2.5:0.1:2.5;
%     y = -2.5:0.1:2.5;
%     contour(x,y,Y);
    
figure;
scatter(X(:,1),X(:,2),[],y);
hold on;
x = -2.3:0.046:2.3;
y = -2.3:0.046:2.3;
z = y_pred;
contour(x,y,z);
hold off;
%%%%
end

