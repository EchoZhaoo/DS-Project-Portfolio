%% Generate Synthetic Data
% 1/(n-1) < p < (lnn)/n
n = 15;     % number of nodes
p = .2;     % probability of each edge
N = 1e7;    % number of data in the whole simulatio proess
num = 1e5;  % number of sample 
h =.5;      % step size
method = 'RungeKutta';
[sample_RungeKutta, S, ~] = GenerateData(n, p, N, num, h, method);
save('sample_RungeKutta.mat');
sample = sample_RungeKutta;
clear p N num h method 

%% Estimate group structure using Graphical Lasso
lambda = .47;  maxIt = 1e6;    tol = 1e-4;
[Theta, ~] = GraphicalLasso(S, lambda, maxIt, tol);
Est_1 = Theta.*(abs(Theta) > .1); 
Est_1 = (abs(Est_1) > 0) - eye(n);
figure
G = graph(Est_1);
plot(G,'om');
title('The Group Structure Estimated by Graphical Lasso');
clear lambda maxIt tol Theta G

%%
clearvars -except A Est_1 h lambda maxIt method n N num p par_cor S sample Theta tol;

%% Thresholding the Correlation Matrix
corr = corrcoef(sample');            % behaves so terrible that I cannot even do thresholding 
Est_2 = corr.*(corr > .68);          % 100% correction rate
Est_2 = (abs(Est_2) > 0) - eye(n);
figure
G = graph(Est_2);
plot(G,'om');
title('The Group Structure Estimated by Correlation Matrix');
clear G

%% Partial Correlation
par_cor = partialcorr(sample');
% Thresholding 
Est_3 = par_cor.*(par_cor > .1);          % 100% correction rate
Est_3 = (abs(Est_3) > 0) - eye(n);
figure
G = graph(Est_3);
plot(G,'om');
title('The Group Structure Estimated by Partial Correlation');
clear G

%% The Exact Mutual Information between two variates X and Y
%  of the bivariate normal distribution with the correlation
%  coefficient rho is I(X,Y) = .5*log(1/(1-rho^2))
MI = zeros(n,n);
for i = 1:n
    for j = 1:n
        if j == i, continue; end
        rho = corr(i,j);
        MI(i,j) = .5*log(1/(1-rho^2));
    end
end
clear i j rho

%% Estimate Mutual Information Based on Histogram Method
% nbins = [3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];
% nbins = [20,25,30,35,40];
nbins = [30,31,32,33,34,35,36,37,38,39,40];
m = size(nbins,2);
error = zeros(m,m);
for binNum_X = nbins
    for binNum_Y = nbins
        MI_Histogram = zeros(n,n);
        for i = 1:n
            for j = 1:n
                MI_Histogram(i,j) = Histogram(sample(i,:),sample(j,:),binNum_X,binNum_Y);
            end
        end
        MI_Histogram = MI_Histogram - diag(diag(MI_Histogram));
        i = find(nbins == binNum_X);
        j = find(nbins == binNum_Y);
        error(i,j) = norm(MI - MI_Histogram); 
    end
end
minimum = min(min(error));
[i,j] = find(error == minimum);
nbins = [nbins(i); nbins(j)];       % binNum_X = 34, binNum_Y = 37
disp(minimum); disp(nbins);

for i = 1:n
    for j = 1:n
        MI_Histogram(i,j) = Histogram(sample(i,:),sample(j,:),nbins(1),nbins(2));
    end
end
clear nbins m binNum_X binNum_Y i j

%% Estimate Mutual Information by Fuzzy Histogram Method  
% nbins = [30,31,32,33,34,35,36,37,38,39,40];
fprintf('Lets start!\n');
nbins = [26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44];
% nbins = 15;
m1 = size(nbins,2);
error = zeros(m1,m1);
% beta = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
beta = 1;
% m2 = size(beta,2);
Error = cell([],5);
for beta_X = beta
    fprintf('beta_X = %d starts\n', beta_X);
    for beta_Y = beta
        fprintf('beta_Y = %d starts\n', beta_Y);
        for binNum_X = nbins(11:15) % need to start from 11 to 15 (19_1_13)
            fprintf('binNum_X = %d starts\n', binNum_X);
            for binNum_Y = nbins(8:15)
                fprintf('binNum_Y = %d starts\n', binNum_Y);
                MI_FuzzyHist = zeros(n,n);
                for i = 1:n
                    for j = 1:n
                        MI_FuzzyHist(i,j) = FuzzyHistogram(sample(i,:),sample(j,:),binNum_X,binNum_Y,beta_X,beta_Y);
                    end
                end
                MI_FuzzyHist = MI_FuzzyHist - diag(diag(MI_FuzzyHist));
                i = find(nbins == binNum_X);
                j = find(nbins == binNum_Y);
                error(i,j) = norm(MI - MI_FuzzyHist); 
            end
        end
        minimum = min(min(error));
        [i,j] = find(error == minimum);
        binNum_X = nbins(i); binNum_Y = nbins(j); 
        Error(end+1,:) = {beta_X, beta_Y, binNum_X, binNum_Y, minimum};
    end
end

error = cell2mat(Error(:,5));
minimum = min(error);
[i,~] = find(error == minimum);
beta_X = cell2mat(Error(i,1)); beta_Y = cell2mat(Error(i,2)); 
binNum_X = cell2mat(Error(i,3)); binNum_Y = cell2mat(Error(i,4));
formatSpec = 'The optimal solution turns out to be:\n beta_X = %d, beta_Y = %d, binNum_X = %d, binNum_Y = %d, minimum = %d\n';
fprintf(formatSpec, beta_X, beta_Y, binNum_X, binNum_Y, minimum);
% for i = 1:n
%     for j = 1:n
%         MI_FuzzyHist(i,j) = FuzzyHistogram(sample(i,:),sample(j,:),binNum_X,binNum_Y,beta_X,beta_Y);
%     end
% end        

fprintf('DONE!\n');

clear i j nbins m1 beta beta_X beta_Y binNum_X binNum_Y formatSpec error minimum 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The optimal solution turns out to be:
%  beta_X = 2, beta_Y = 2, binNum_X = 30, binNum_Y = 40, minimum = 2.930006e-02
% The optimal solution turns out to be:
%  beta_X = 1, beta_Y = 1, binNum_X = 34, binNum_Y = 38, minimum = 0.026963240440691
% The optimal solution turns out to be:
%  beta_X = 3, beta_Y = 3, binNum_X = 30, binNum_Y = 45, minimum = 2.930217e-02
% The optimal solution turns out to be:
%  beta_X = 4, beta_Y = 4, binNum_X = 30, binNum_Y = 45, minimum = 2.930115e-02
% The optimal solution turns out to be:
%  beta_X = 5, beta_Y = 5, binNum_X = 45, binNum_Y = 30, minimum = 2.930109e-02
% The optimal solution turns out to be:
%  beta_X = 6, beta_Y = 6, binNum_X = 30, binNum_Y = 45, minimum = 2.930109e-02



%% Estimate Mutual Information using Kernel Density Estimator
% Using Gaussian probability density function for K(u)

% Estimate density of variable X
pts = (min(X):.01:max(X));
[p_X,x] = ksdensity(X,pts);
histogram(X,40);
hold on
yyaxis right
plot(x,p_X,'Color','b','LineWidth',2);
hold off

[p_X,~] = ksdensity(X,X); 

% Estimate density of variable Y
pts = (min(Y):.01:max(Y));
[p_Y,y] = ksdensity(Y,pts);
histogram(Y,40);
hold on
yyaxis right
plot(y,p_Y,'Color','b','LineWidth',2);
hold off

[p_Y,~] = ksdensity(Y,Y); 


% Estimate density of (X,Y)
XY = [X;Y];
n = size(XY,2);
d = 2;
% Silverman's rule of thumb for the bandwidth
bw_X = std(X)*(4/(n*(d+2)))^(1/(d+4));
bw_Y = std(Y)*(4/(n*(d+2)))^(1/(d+4));
p_XY = mvksdensity(XY',XY','Bandwidth',[bw_X bw_Y]);

pts_X = (min(X):.01:max(X));
pts = [pts_X; pts_X];

f_XY = mvksdensity(XY',pts','Bandwidth',[bw_X bw_Y]);

histogram2(X,Y,40);
xlabel('X')
ylabel('Y')
hold on
posAx1 = get(gca,'Position');       % get position of current axes
hAx2 = axes('Position',posAx1);     % create duplicate axes at same position
plot3(hAx2,pts_X,pts_X,f_XY,'Color','b','LineWidth',2);
set(hAx2,'Visible','off'); 
hold off

% Compute Mutual Information
I = 0;
for i = n
    I = I + p_XY(i)*log(p_XY(i)/(p_X(i)*p_Y(i)));
end


%% Estimate Mutual Information by KNN
MI_KNN = zeros(n,n);
% ki = [5,6,7,8,9,10,13,15];
ki = 5;
for k = ki
    fprintf('k = %d starts\n', k);
    for i = 1:n
        fprintf('i = %d starts\n', i);
        for j = 1:n
            fprintf('j = %d starts\n', j);
            if j == i, continue; end
            MI_KNN(i,j) = KNN(sample(i,:),sample(j,:),k,1);
        end
    end
end

% (X1,X2)
% k = 5 -- 0.1977
% k = 6 -- 0.1983
% k = 10 -- 0.2008 
% k = 15 -- 0.2010

% (X1,X3) k = 5 -- 0.2668


%%
figure
scatter(X,Y,'y');
hold on
scatter(point(1), point(2),'filled','r');
hold on 
scatter(Z(Idx,1),Z(Idx,2),'filled','k');
hold on 
ylim = get(gca,'Ylim'); 
xlim = get(gca,'Xlim');
plot([point(1)-D,point(1)-D],ylim,'k--');
plot([point(1)+D,point(1)+D],ylim,'k--');
plot(xlim,[point(2)-D,point(2)-D],'k--');
plot(xlim,[point(2)+D,point(2)+D],'k--');
hold off

