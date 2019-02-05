function [sample, THETA] = ImplicitEuler(L, N, num, h)
% Implicit Euler's Method
% v(t+h) = v(t) + h*v'(t+h)
% where v'(t+h) = -C\[G*v(t+h) + sqrtm(G)*w] = -v(t+h) - C\sqrtm(G)*w
% => v(t+h) = [v(t) - h*(C\sqrtm(G))*w]/(1+h)
% Input: L = pertured Laplacian Matrix
%        N = number of simulations
%        num = number of samples
%        h = stepsize
% Output: sample = generated sample set

n = size(L,1);
par = L\sqrtm(L);
V = zeros(n,N+1);
V(:,1) = normrnd(0,.01,[n,1]);

for i = 1:N
    w = normrnd(0,2,[n,1]);
    V(:,i+1) = (V(:,i) - h*par*w)/(1+h);
end
THETA = inv(cov(V'));
sample = V(:, end-num+1:end);
