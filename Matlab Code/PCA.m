% CSCI 5521 Introduction to Machine Learning, Fall 2017
% By Chunni Zhao
% Demonstration of PCA 

mu = [-1 -1;
      1 1;
      -1 1;
       1 -1]

% Shared covariance matrix
sigma = [1 0.7;0.7 1];

pj = rand (3,3);
pj = pj * diag(sum(pj))^-1;

for i=1:4
    range=(i-1)*100;
    rm(range+1:range+100,:) = mvnrnd(mu(i,:)*2,sigma,100);
    R(range+1:range+100,:) = [rm(range+1:range+100,:) zeros(100,1)] * pj;
end

subplot(1,2,1);
plot3(R(1:100,1),R(1:100,2),R(1:100,3),'ob'); hold on;
plot3(R(101:200,1),R(101:200,2),R(101:200,3),'xr'); hold on;
plot3(R(201:300,1),R(201:300,2),R(201:300,3),'vg'); hold on;
plot3(R(301:400,1),R(301:400,2),R(301:400,3),'hy');

[coeff,score,latent] = pca(R);
P = score(:,1:2);
% pause
subplot(1,2,2);
plot(P(1:100,1),P(1:100,2),'ob'); hold on;
plot(P(101:200,1),P(101:200,2),'xr'); hold on;
plot(P(201:300,1),P(201:300,2),'vg'); hold on;
plot(P(301:400,1),P(301:400,2),'hy');



