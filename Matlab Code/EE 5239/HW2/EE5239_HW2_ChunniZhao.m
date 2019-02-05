%% Question 3: Programming Assignment
%%%%%%%%%%%% Preparation %%%%%%%%%%%%
clc;
clear;

% Problem Dimension 
n = 100;

% Condition Number
c = 5000;

rng(10);
% Generating Data Matrix Q
A = randn(n); % return an n x n matrix of normally distributed random numbers.
[V,D] = svd(A);
alpha = (c*D(n,n)/D(1,1))^(1/(n-1));
for i = 1:n;
    a(i) = alpha^(n-i);
end
D = D*diag(a);
Q = V'*D*V;

% Generating Vector b
b = randn(n,1);

% Declare Function
func = @(x) 1/2*x'*Q*x + b'*x;

% First Order Derivative
grad = @(x) Q*x + b;


%% 1) Steepest descent method with Armijo step size rule
% Initialization of x
x = ones(n,1);

g = Q*x + b;
obj = func(x);

sigma = .1;
beta = .5;

k = 0;              % k = # iteraions
prog = [];          % progression of objective values
t = [];             % CPU time

tic;
while norm(g) > 1e-4
    d = -g;         % steepest gradient descent direction
    a = 1;
    newobj = func(x + a*d);
    while (newobj - obj) > sigma*a*g'*d
        a = a*beta;
        newobj = func(x + a*d);
    end
    x = x + a*d;
    prog = cat(1, prog, [k, obj]);
    obj = newobj;
    g = grad(x);
    k = k + 1;
    t = cat(1, t, [toc, newobj]);
end

% Plot of CPU time  
figure
subplot(2,1,1);
plot(t(:,1), t(:,2))
title({'CPU Time','Steepest GD (n = 500, c = 5000)'})
xlabel('CPU time')
ylabel('Objective Values')
ax = gca;
ax.FontSize = 15;

% Plot of progression of objective values
subplot(2,1,2);
plot(prog(:,1), prog(:,2))
title({'Progression of Objective Values','Steepest GD (n = 500, c = 5000)'})
xlabel('Iteration')
ylabel('Objective Values')
ax = gca;
ax.FontSize = 15;


%% 2) Diagonally scaled gradient method (using the Hessian diagonals), constant step size rule
x = ones(n,1);      % Initialization of x

H = Q;              % n by n
D = 1./diag(H);     % n by 1
D = diag(D);        % n by n
g = Q*x + b;
obj = func(x);

L = max(eig(Q));
d = -D'*g;
a_k = (abs(g'*d))/(L*(norm(d)^2));  
s = 1.5*round(a_k,3);           % constant stepsize that could make sure convergence

k = 0;              % k = # iteraions
prog = [];          % progression of objective values
t = [];             % CPU time

tic;
while norm(g) > 1e-4
    d = -D'*g;         % diagonally scaled  gradient descent direction
    x = x + s*d;
    prog = cat(1, prog, [k, obj]);
    newobj = func(x + a*d);
    obj = newobj;
    g = grad(x);
    k = k + 1;
    t = cat(1, t, [toc, newobj]);
end

% Plot of CPU time 
figure
subplot(2,1,1);
plot(t(:,1), t(:,2))
title({'CPU Time','Diagonally Scaled Gradient (n = 500, c = 10)'})
xlabel('CPU time')
ylabel('Objective Values')
ax = gca;
ax.FontSize = 15;

% Plot of progression of objective values
subplot(2,1,2);
plot(prog(:,1), prog(:,2))
title({'Progression of Objective Values','Diagonally Scaled Gradient (n = 500, c = 10)'})
xlabel('Iteration')
ylabel('Objective Values')
ax = gca;
ax.FontSize = 15;


%% 3) Conjugate gradient method, exact minimization step size rule
x = ones(n,1);      % Initialization of x

g = grad(x);        % g_0       n by 1
d = -g;             % d_0       n by 1
obj = func(x);

k = 0;              % k = # iteraions
prog = [];          % progression of objective values
t = [];             % CPU time

tic;
while norm(g) > 1e-4
    a = -((b + Q*x)'*d)/(d'*Q*d);   % k_th stepsize 
    prog = cat(1, prog, [k, obj]);
    newobj = func(x + a*d);        
    obj = newobj;
    x = x + a*d;                    % x_k     
    g_next = grad(x);               % g_k           
    beta = (g_next'*g_next)/(g'*g); % g = g_(k-1)
    g = g_next;
    d_next = -g + beta*d;           % d_k
    d = d_next;                     
    k = k + 1;
    t = cat(1, t, [toc, newobj]);
end

% Plot of CPU time 
figure
subplot(2,1,1);
plot(t(:,1), t(:,2))
title({'CPU Time','Conjugate Gradient (n = 500, c = 5000)'})
xlabel('CPU time')
ylabel('Objective Values')
ax = gca;
ax.FontSize = 15;

% Plot of progression of objective values
subplot(2,1,2);
plot(prog(:,1), prog(:,2))
title({'Progression of Objective Values','Congjugate Gradient (n = 500, c = 5000)'})
xlabel('Iteration')
ylabel('Objective Values')
ax = gca;
ax.FontSize = 15;


%% 4) Preconditioned conjugate gradient method (using the Hessian diagonals), exact minimization step size rule    
x = ones(n,1);              % Initialization of x

H = diag((1./diag(Q)));     % n by n    preconditioned matrix
g = grad(x);                % n by 1    g_0
d = -H*g;                   % n by 1    d_0
obj = func(x);


k = 0;              % k = # iteraions
prog = [];          % progression of objective values
t = [];             % CPU time

tic;
while norm(g) > 1e-4
    a = -((b + Q*x)'*d)/(d'*Q*d);       % k_th stepsize 
    prog = cat(1, prog, [k, obj]);
    newobj = func(x + a*d);        
    obj = newobj;
    x = x + a*d;                        % x_k
    g_next = grad(x);                   % g_k    n by 1       
    beta = (g_next'*H*g_next)/(g'*H*g); % g = g_(k-1)
    g = g_next;
    d_next = -H*g + beta*d;             % d_k
    d = d_next;                     
    k = k + 1;
    t = cat(1, t, [toc, newobj]);
end

% Plot of CPU time 
figure
subplot(2,1,1);
plot(t(:,1), t(:,2))
title({'CPU Time','Preconditioned Conjugate Gradient (n = 100, c = 5000)'})
xlabel('CPU time')
ylabel('Objective Values')
ax = gca;
ax.FontSize = 15;

% Plot of progression of objective values
subplot(2,1,2);
plot(prog(:,1), prog(:,2))
title({'Progression of Objective Values','Preconditioned Congjugate Gradient (n = 100, c = 5000)'})
xlabel('Iteration')
ylabel('Objective Values')
ax = gca;
ax.FontSize = 15;
