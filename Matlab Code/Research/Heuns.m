function [sample, THETA] = Heuns(L, N, num, h)
% Using Heun's Method (Second-order Runge_Kutta Method)
% v(t+h) = v(t) + .5*h*(k_1 + k_2)
% where k_1 = v'(t) = -v(t) - L\sqrtm(L)*w
%       k_2 = (h-1)v(t) + h*L\sqrtm(L)*w - L\sqrtm(L)*w = (h-1)*[v(t) + L\sqrtm(L)*w]
% Input: L = pertured Laplacian Matrix
%        N = number of simulations
%        num = size of sample 
%        h = stepsize
% Output: sample = generated sample set

n = size(L,1);
par = L\sqrtm(L);
V = zeros(n,N+1);
V(:,1) = normrnd(0,.01,[n,1]);

for i = 1:N
    w = normrnd(0,2,[n,1]);
    k_1 = -V(:,i) - par*w;
    k_2 = (h-1)*(V(:,i) + par*w);
    V(:,i+1) = V(:,i) + .5*h*(k_1 + k_2);
end
THETA = inv(cov(V'));
sample = V(:, end-num+1:end);

