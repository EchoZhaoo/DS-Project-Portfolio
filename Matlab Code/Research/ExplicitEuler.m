function [sample, THETA] = ExplicitEuler(L, N, num, h)
% v(t+h) = v(t) + h*v'(t) 
% where v'(t) = -C\[G*v(t) + sqrtm(G)*w] = -[v(t) + C\sqrtm(G)*w]
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
    V(:,i+1) = V(:,i) - h*(V(:,i) + par*w);
end
THETA = inv(cov(V'));
sample = V(:, end-num+1:end);
