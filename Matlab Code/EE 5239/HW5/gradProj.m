function x = gradProj(H, f, l, u, s, alpha, maxIt)
% Gradient Projection Methods with constant stepsize
% Object function -- 1/2*x'*H*x - f'*x
% Constraints -- LB <= x <= UB
% Input -- H(m x m); f(m x 1); 
%          l(1 x 1) lower bound; u(1 x 1) upper bound
% Output -- x(m x 1)

m = size(H,1);
x = ones(m,1);      % Initialization

for i = 1:maxIt
    grad = H*x - f;     % m x 1
    temp = x - s*grad;
    x_bar = zeros(m,1);
    for j = 1:m
        x_bar(j) = projection(temp(j), l, u);
    end
    x_next = x + alpha*(x_bar - x);
    x = x_next;
end

