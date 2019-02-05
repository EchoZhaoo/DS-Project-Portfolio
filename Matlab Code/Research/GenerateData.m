function [sample, S, THETA] = GenerateData(n, p, N, num, h, method)
% Input: n -- number of nodes
%        p -- probability of each edge
%        N -- number of simulations
%        num -- number of samples 
%        h -- stepsize for methods that solve ordinary differential equation
%        method -- type of method to use 
%               'Heuns' = Heun's Method (Second-order Runge_Kutta Method)
%               'RungeKutta' = Forth-order Runge_Kutta Method
%               'TaylorSeries' = Second-Order Talyor Series Method
%               'ImplicitEuler' = Implicit Euler's Method
%               'ExplicitEuler' = Explicit Euler's Method
% Output: sample -- sample simulation
%         S -- sample covariance matrix
%         THETA -- true pricision matrix


    % Instantiate the graph. 
    % A -- adjacency matrix for the graph 
    rng(4);
    A = rand(n,n) < p;      % tell it's smaller than p or not, return 0 or 1;
    A = triu(A,1);          % return the element on the 1th diagonal of G
    A = A + A'; 
    % Plot the graph
    figure
    G = graph(A);
    plot(G,'om');
    title('The True Group Structure');

    %% Construct Laplacian Matrix 
    d = sum(A,2);
    D = diag(d);
    L = D - A;
    L(6,6) = L(6,6) + 4;

    %% The RC Circuit Model
    % Formula -- L*v_dot = -L*v - sqrtm(L)*w
    switch method
        case 'Heuns'
            [sample, THETA] = Heuns(L, N, num, h);
        case 'RungeKutta'
            [sample, THETA] = RungeKutta(L, N, num, h);
        case 'TalyorSeries'
            [sample, THETA] = TalyorSeries(L, N, num, h);
        case 'ImplicitEuler'
            [sample, THETA] = ImplicitEuler(L, N, num, h);
        case 'ExplicitEuler'
            [sample, THETA] = ExplicitEuler(L, N, num, h);
    end
    S = cov(sample');

