function MI = Histogram(X, Y, binNum_X, binNum_Y)
% Using Histogram Method to estimate the Mutual Information of two
% variables based on this formula: 
% I(X,Y) = sum_ij(k_ij/N)*log(k_ij*N/(k_i*k_j)) 
% where N is the number of samples
% Input: X(1 x N) -- sample vector
%        Y(1 x N) -- sample vector
%        binNum_X -- number of bins for variable X
%        binNum_Y -- number of bins for variable Y
% Output: MI (scalar) -- Estimlated Mutual Information between variables X
%         and Y based on Histogram Method

N = size(X,2);
% count_X/ count_Y/ count_XY -- number of elements assinged to each bin
[count_X, ~] = histcounts(X, binNum_X);     % count_X (1 x binNum_X)
[count_Y, ~] = histcounts(Y, binNum_Y);     % count_Y (1 x binNum_Y)
nbins = [binNum_X, binNum_Y];
[count_XY,~,~] = histcounts2(X,Y,nbins);    % count_XY (binNum_X x binNum_Y)
MI = 0;
for i = 1:binNum_X
    k_i = count_X(1,i);
    if k_i == 0, continue; end
    for j = 1:binNum_Y
        k_j = count_Y(1,j);
        if k_j == 0, continue; end
        k_ij = count_XY(i,j);
        if k_ij == 0, continue; end
        MI = MI + (k_ij/N)*log((k_ij*N)/(k_i*k_j));
    end
end
end
