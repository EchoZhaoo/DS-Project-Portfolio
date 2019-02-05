%% EE 5239 Homework 4 (Linear Regression)
%% Set environment
% read the data
clear
trn = load('features_train.txt');

% getting the size of the matrix A
[a, ~] = size(trn);

% calculate the matrix A
A = trn(:,2:3);
A(:,3) = 1;

% get the eigenvalue of A'A
eigen = eig(A'*A);
L = max(eigen);
limit = 1/L;

% calculate vector b
for i = 1:a
    if trn(i,1) == 1
        b(i,1) = 1;
    else
        b(i,1) = -1;
    end
end

% problem dimension
n = 3;

% max iteration time
max_time = 1e6;

%% Steepest descent with constant stepsize
% start point and its value and gradient
x(1:n,1) = 1;
value(1) = func(x(1:n,1),A,b);
k = 1;
d(:,1) = -A'*(A*x(1:n,1)-b);
gradient(1) = norm(d(:,1),2);

% Constant stepsize
alpha = 1e-5;

% Stop criteria
while norm(d(:,k),2)/norm(d(:,1),2) > 1e-6 && k <= max_time
    x(1:n,k+1) = x(1:n,k)+alpha*d(:,k);             % get the new point
    value(k+1) = func(x(1:n,k+1),A,b);              % get the new value
    k = k+1;                                        % update iteration time
    d(:,k) = -A'*(A*x(1:n,k)-b);                    % next descent direction
    gradient(k) = norm(d(:,k),2);                   % the new gradient norm
end

%% Plot the evolution of objective fucntion
plot(value);
title_text = 'Evolution of the objective funciton';
title(sprintf('\\begin{tabular}{c} %s \\end{tabular}', title_text), 'Interpreter', 'latex')
xlabel('Iteration Number', 'Interpreter', 'latex')
ylabel('Objective Values', 'Interpreter', 'latex')
ax = gca;
ax.FontSize = 15;

%% Testing
x_op = x(:,end);
test = load('features_test.txt');
A_tst = test(:,2:3);
A_tst(:,3) = 1;
n_tst = size(A_tst,1);

% Prediction values
pred = A_tst*x_op;              
for i = 1:n_tst
    if pred(i) < 0
        pred(i) = -1;
    else 
        pred(i) = 1;
    end
end

% True labels of test data set
b_tst = -ones(n_tst, 1);
for i = 1:n_tst
    if test(i,1) == 1
        b_tst(i,1) = 1;
    end
end

% Compute error rate
error = 0;
for i = 1:n_tst
    if pred(i) ~= b_tst(i)
        error = error + 1;
    end
end
err_rate = error/n_tst;
fprintf('The error rate is %5.2f%%\n', err_rate*100);

%% Plot Boundary
PlotBoundary(A_tst(:,1:2), pred, x_op);
