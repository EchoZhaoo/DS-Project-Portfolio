% CSCI 5521 Introduction to Machine Learning
% By Chunni Zhao
% Demonstration of Classification by 1-D Gaussians 

mu1 = -5;
mu2 = 5;
sd1 = 3;
sd2 = 3;
pc1 = 0.5;
pc2 = 0.5;
sd = max(sd1,sd2);
ix = -6*sd-1:1e-1:6*sd+1; %covers more than 99% of the curve

iy1 = pdf('normal', ix, mu1, sd1);
iy2 = pdf('normal', ix, mu2, sd2);

subplot(1,2,1);
plot(ix,iy1,'b'); hold on;
plot(ix,iy2,'r');
title('PDF');

iy1 = iy1*pc1;
iy2 = iy2*pc2;

iy1_n = iy1 ./ (iy1+iy2);
iy2_n = iy2 ./ (iy1+iy2);
subplot(1,2,2);
plot(ix,iy1_n,'b'); hold on;
plot(ix,iy2_n,'r');
title('Posteriors');