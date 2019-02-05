function MI = FuzzyHistogram(X, Y, binNum_X, binNum_Y, beta_X, beta_Y)
% Fuzzy Histogram Method: using GNF(Generalized Normal Function) as
% membership function to do histogram density estimation
% Input: X(1 x N) -- sample vector
%        Y(1 x N) -- sample vector
%        binNum_X -- number of bins for variable X
%        binNum_Y -- number of bins for variable Y
%        beta_X/beta_Y -- parameter that defines the shape of GNF
%               beta = 1, the pdf of GNF will be the Laplace distribution 
%               beta = 2, the pdf of GNF will be the normal distribution
%               beta = infinity, the membership functions tend to crisp
%               functions 
% Output: MI (scalar) -- Estimlated Mutual Information between variables X
%         and Y based on Fuzzy Histogram Method


% Get the histogram information: 
%   edges_X/Y -- bin edges for each bin, 
%                   number of edges in total = binNum + 1
%   bin_X/Y -- index number of bin that each element is assigned to
N = size(X,2);
[~, edges_X, bin_X] = histcounts(X, binNum_X);        
[~, edges_Y, bin_Y] = histcounts(Y, binNum_Y); 

% Compute the mean value of each bin
mu_X = zeros(binNum_X,1);     
for i = 1:binNum_X
    mu_X(i) = (edges_X(i) + edges_X(i+1))/2;
end

mu_Y = zeros(binNum_Y,1);     
for i = 1:binNum_Y
    mu_Y(i) = (edges_Y(i) + edges_Y(i+1))/2;
end

% Compute assign bin mean value to each element of X/Y
MU_X = zeros(1,N);             
for i = 1:N
    binIdx = bin_X(i);
    MU_X(i) = mu_X(binIdx);
end

MU_Y = zeros(1,N);             
for i = 1:N
    binIdx = bin_Y(i);
    MU_Y(i) = mu_Y(binIdx);
end

% Compute membership values 
% alpha_X/Y -- scale parameter
% alpha_X = h_X/2, where h_X = (max(X)-min(X))/(binNum_X -1)
% alpha_Y = h_Y/2, where h_Y = (max(Y)-min(Y))/(binNum_Y -1)
alpha_X = .5*(max(X) - min(X)/(binNum_X - 1));
alpha_Y = .5*(max(Y) - min(Y)/(binNum_Y - 1));
        
par1 = beta_X/(2*alpha_X*gamma(1/beta_X));
par2 = -(abs(X-MU_X)./alpha_X).^beta_X;
GNF_X = (par1).*exp(par2); 

par1 = beta_Y/(2*alpha_Y*gamma(1/beta_Y));
par2 = -(abs(Y-MU_Y)./alpha_Y).^beta_Y;
GNF_Y = (par1).*exp(par2); 

% Compute entropy of X/Y
H_X = entropy(GNF_X, binNum_X, bin_X);
H_Y = entropy(GNF_Y, binNum_Y, bin_Y);

% Compute entropy of (X,Y)
H_XY = entropy2(X, Y, GNF_X, GNF_Y, binNum_X, binNum_Y, edges_X, edges_Y);
        
% Compute the Mutual Information
MI = H_X + H_Y - H_XY;

end

% figure
% histogram(X,30)
% hold on
% % plot(mu_X,count_X,'g.-')
% % hold on
% yyaxis right
% scatter(X,GNF_X)
% hold on
% ylim = get(gca,'Ylim');
% for i = 1:size(edges_X,2)
%     plot([edges_X(i),edges_X(i)],ylim,'b--')
% end
% hold off





