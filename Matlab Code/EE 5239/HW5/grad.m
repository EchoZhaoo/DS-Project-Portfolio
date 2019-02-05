function g = grad(X, y, lambda, i)
% Compute the gradient w.r.t i_th element of the vector lambda
% Input -- X (m x 3): data 
%          y (m x 1): label
%          lambda (m x 1): Lagrangian multiplier
%          i (scalar): index of element in vetcor lambda
% Output -- g (scalar): the gradient w.r.t i_th element of vector lambda

[m,n] = size(X);
temp = zeros(1,n);      % 1 by n
for j = 1:m
    temp = temp + lambda(j)*y(j)*X(j,:);
end
g = 1 - y(i)*X(i,:)*temp';
end