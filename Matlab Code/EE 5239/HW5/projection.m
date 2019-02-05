function y = projection(x, l, u)
% Projection on some set
% Input -- x(1 x 1)
%          l(1 x 1): lower bound
%          u(1 x 1): upper bound
% Output -- y(1 x 1): porjected value

if x < l, y = l; 
elseif x > u, y = u;
else
    y = x;
end
end