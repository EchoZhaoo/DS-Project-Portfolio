% Graphical Lasso function
% Author: Xiaohui Chen (xiaohuic@ece.ubc.ca)
% Version: 2012-Feb

function [Theta, W] = GraphicalLasso(S, rho, maxIt, tol)

% Solve the graphical Lasso
% minimize_{Theta > 0} tr(S*Theta) - logdet(Theta) + rho * ||Theta||_1
% Ref: Friedman et al. (2007) Sparse inverse covariance estimation with the
% graphical lasso. Biostatistics.
% Note: This function needs to call an algorithm that solves the Lasso
% problem. Here, we choose to use to the function *lassoShooting* (shooting
% algorithm) for this purpose. However, any Lasso algorithm in the
% penelized form will work.
%
% Input:
% S -- sample covariance matrix
% rho --  regularization parameter
% maxIt -- maximum number of iterations
% tol -- convergence tolerance level
%
% Output:
% Theta -- inverse covariance matrix estimate
% W -- regularized covariance matrix estimate, W = Theta^-1

n = size(S,1);

% Initialization
W = S + rho * eye(n);   % diagonal of W remains unchanged
W_old = W;
i = 0;

% Graphical Lasso loop
while i < maxIt
    i = i + 1;
    for j = n:-1:1
        jminus = setdiff(1:n,j);
        [V,D] = eig(W(jminus,jminus));      % W(jminus,jminus) -> W_11; V: right eigenvectors
        d = diag(D);
        X = V * diag(sqrt(d)) * V';         % W_11^(1/2)
        Y = V * diag(1./sqrt(d)) * V' * S(jminus,j);    % W_11^(-1/2) * s_12
        b = lassoShooting(X, Y, rho, maxIt, tol);       % b -> beta
        W(jminus,j) = W(jminus,jminus) * b; % W(jminus,j) -> w_12
        W(j,jminus) = W(jminus,j)';         % W(j,jminus) -> w_21
    end
    % Stop criterion
    if norm(W-W_old,1) < tol
        break; 
    end
    W_old = W;
end
if i == maxIt
    fprintf('%s\n', 'Maximum number of iteration reached, glasso may not converge.');
end

Theta = W^-1;



% Shooting algorithm for Lasso (unstandardized version)
% Pathwise coordinate descent for the lasso
function b = lassoShooting(X, Y, lambda, maxIt, tol)
% Initialization
[m,n] = size(X);
if n > m
    b = zeros(n,1);         % From the null model, if n > m
else
    b = X\Y;              % From the OLS estimate, if n <= m
end
b_old = b;
i = 0;

% Precompute X'X and X'Y
XTX = X'*X;
XTY = X'*Y;

% Shooting loop
while i < maxIt
    i = i + 1;
    for j = 1:n
        jminus = setdiff(1:n,j);
        S0 = XTX(j,jminus)*b(jminus) - XTY(j);  % S0 = X(:,j)'*(X(:,jminus)*b(jminus)-Y)
        if S0 > lambda
            b(j) = (lambda-S0) / norm(X(:,j),2)^2;
        elseif S0 < -lambda
            b(j) = -(lambda+S0) / norm(X(:,j),2)^2;
        else
            b(j) = 0;
        end
    end
    delta = norm(b-b_old,1);    % Norm change during successive iterations
    if delta < tol, break; end
    b_old = b;
end
if i == maxIt
    fprintf('%s\n', 'Maximum number of iteration reached, shooting may not converge.');
end
