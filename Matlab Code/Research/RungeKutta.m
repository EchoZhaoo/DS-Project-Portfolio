function [sample, THETA] = RungeKutta(L, N, num, h)
% v(t+h) = v(t) + (h/6)*(k_1 + 2*k_2 + 2*k_3 + k_4)
% where k_1 = -v(t) - C\sqrtm(G)*w;
%       k_2 = (.5*h - 1)*(v(t) + C\sqrtm(G)*w);
%       k_3 = -(.5*h*(.5*h - 1) + 1)*(v(t) + C\sqrtm(G)*w);
%       k_4 = (h*(.5*h*(.5*h - 1) - 1) - 1)*(v(t) + C\sqrtm(G)*w);
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
    temp = V(:,i) + par*w;
    k_1 = -temp;
    k_2 = (.5*h - 1)*temp;
    k_3 = -(.5*h*(.5*h - 1) + 1)*temp;
    k_4 = (h*(.5*h*(.5*h - 1) - 1) - 1)*temp;
    V(:,i+1) = V(:,i) + (h/6)*(k_1 + 2*k_2 + 2*k_3 + k_4);
end
THETA = inv(cov(V'));
sample = V(:, end-num+1:end);
