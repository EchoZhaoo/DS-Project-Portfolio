% CSCI 5521 Introduction to Machine Learning, Fall 2017
% Chunni Zhao
% Comparison of LDA and PCA

x_range = -5:0.1:5;

M = size(x_range,2);
N = size(x_range,2);
K = size(x_range,2);

X = zeros(M+N+K,2);

X(:,1) = [x_range x_range x_range];
X(:,2) = [x_range-1 x_range x_range+1] + 0.3*rand(M+N+K,1)';
%%%%%%%%%%%%%%%%%%%%%%%%%%%

Y = [zeros(M,1); ones(N,1);2 * ones(K,1)];

subplot(1,3,1);
plot(X(1:M,1),X(1:M,2),'ob'); hold on;
plot(X(M+1:M+N,1),X(M+1:M+N,2),'xr'); hold on;
plot(X(M+N+1:M+N+K,1),X(M+N+1:M+N+K,2),'gv'); 

% pause
[coeff,score,latent] = pca(X);
subplot(1,3,2);
title('PCA');
plot(score(1:M,1),zeros(M,1),'ob'); hold on;
plot(score(M+1:M+N,1),zeros(M,1),'xr'); hold on;
plot(score(M+N+1:M+N+K,1),zeros(M,1),'gv'); 
% pause
%
% % Calculate linear discriminant coefficients
V = LDA(X,Y); %implement your own LDA function
%
% % Calulcate linear scores for training data
L = [ones(size(X,1),1) X] * V';
subplot(1,3,3);
title('LDA');
plot(L(1:M,1),zeros(M,1),'ob'); hold on;
plot(L(M+1:M+N,1),zeros(M,1),'xr'); hold on;
plot(L(M+N+1:M+N+K,1),zeros(M,1),'gv'); 

%

