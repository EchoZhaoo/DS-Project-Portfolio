%% EE 5239 Homework 4 Logistic Regression
%% Set environment
% Load Data
clear
formatSpec = '%f %f %f'; 

% Load training set
fileID = fopen('features_train.txt','r');                              
size_trn = [3 inf];                            
trn = fscanf(fileID,formatSpec,size_trn);     
fclose(fileID);

% Load test set
fileID = fopen('features_test.txt','r');                               
size_test = [3 inf];                            
test = fscanf(fileID,formatSpec,size_test);     
fclose(fileID);

%% Initialization
M = size(trn,2);                    % # of data points; 7291
A = [trn(2:3,:)' ones(M,1)];        % Input; 7291 by 3
label = trn(1,:)';                  % 0 ~ 9; 7291 by 1
b = zeros(M,1);                     % 7291 by 1
for i = 1:M
    if label(i) == 1
        b(i) = 1;
    end
end

x = ones(3,1);                   % initialize parameters
max_ir = 50000;                  % max iteration number  

% Upper bound for contant stepsize
u = uprBound(A);                % 0.1343
alpha = 1e-4;                   % constant stepsize
d = -grad(x, A, b);             % direction; 3 by 1

%% Algorithm
% Solve the problem to get the optimal solution
f = zeros(max_ir+1, 1);
f(1) = F(x(:,1), A, b);
for i = 1:max_ir
    x(:,i+1) = ConStep(x(:,i), d, alpha);
    f(i+1) = F(x(:,i+1), A, b);
end
plot(1:max_ir+1, f);
x_op = x(:,end);                % 3 by 1

%% Testing
n_tst = size(test,2);                           
A_test = [test(2:3,:)' ones(n_tst,1)];        % n by 3
label = test(1,:)';                           % 0 ~ 9; n by 1
b_test = zeros(n_tst,1);                      % n by 1
for i = 1:n_tst
    if label(i) == 1
        b_test(i) = 1;
    end
end

% Prediction based on test data set
pred = zeros(n_tst,1);
for i = 1:n_tst
    pred(i) = exp(A_test(i,:)*x_op)/(1+exp(A_test(i,:)*x_op));
end

% Compute error rate
error = 0;
for i = 1:n_tst
    if pred(i) < 0.5
        pred(i) = 0;
    else
        pred(i) = 1;
    end
    if pred(i) ~= b_test(i)
        error = error + 1;
    end
end
error_rate = error/size(pred,1);
fprintf('The error rate is %5.2f%%\n', error_rate*100);

%% Plot Boundary
PlotBoundary(A_test(:,1:2), pred, x_op);

%% Object Function Value
function y = F(x, A, b)
    [M, ~] = size(A); 
    y = 0;
    for i = 1:M
        a_i = A(i,:)';          % 3 by 1
        b_i = b(i);
        e_temp = exp(-b_i*x'*a_i);
        temp = log(1 + e_temp);
        y = y + temp;
    end
    y = y/M;
end

%% Compute Gradient 
function g = grad(x, A, b)
    [M, d] = size(A); 
    g = zeros(d,1);
    for i = 1:M
        a_i = A(i,:)';          % d by 1
        b_i = b(i);
        e_temp = exp(b_i*a_i'*x);
        g_temp = (b_i*a_i)/(1+e_temp);
        g = g + g_temp;
    end
    g = -g/M;              % d by 1 
end

%% Using Constant Stepsize
function x_next = ConStep(x, d, alpha)
    x_next = x + alpha*d;
end
        
%% Upper bound for constant stepsize   
function u = uprBound(A)
    [M, ~] = size(A);
    u = 0;
    for i = 1:M
        a_i = A(i,:)';          % d by 1
        temp = norm(a_i)^2;
        u = u + temp;
    end
    u = 2/(u/M);
end
