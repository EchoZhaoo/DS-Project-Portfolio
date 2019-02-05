function lambda = coorDescent(X, y, LB, UB, maxIt)
% Coordinate Descent
% A minimizing problem
% Object function -- L = 1/2*lambda'*y*y'.*(X*X')*lambda - lambda;
% Constraints -- LB <= x <= UB
% Total iterations = maxIt*m
% Input -- H(m x m); f(m x 1); 
%          LB(m x 1) lower bound; UB(m x 1) upper bound
%          X(m x 3);    y(m x 1);
% Output -- lambda(m x 1)

m = size(X,1);
lambda = ones(m,1);         % Initialization
for j = 1:maxIt
    for i = 1:m
        g = grad(X, y, lambda, i);      % the gradient w.r.t i_th element of vector lambda
        temp = (y(i)^2)*(norm(X(i,:))^2);
        lambda(i) = projection(lambda(i)+ g*(1/temp), LB, UB);
    end 
end 
end