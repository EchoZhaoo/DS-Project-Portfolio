function H = entropy2(X, Y, GNF_X, GNF_Y, binNum_X, binNum_Y, edges_X, edges_Y)
% Calculate the entropy of two variables X and Y based on Fuzzy Histogram Method
% Input: X (1 x N) -- sample vector
%        Y (1 x N) -- sample vector
%        GNF_X (1 x N) -- membership values of variable X
%        GNF_Y (1 x N) -- membership values of variable Y
%        binNum_X -- number of bins for variable X is partitioned to 
%        binNum_Y -- number of bins for variable Y is partitioned to 
%        edges_X -- bin edges for variable X
%        edges_Y -- bin edges for variable Y
% Output: H -- entropy of (X,Y)

% calculate the probability
N = size(GNF_X,2);

sumsum = 0;
for i = 1:N
    sumsum = sumsum + GNF_X(i)*GNF_Y(i);
end

value = zeros(binNum_X,binNum_Y);
for i = 1:binNum_X
    a = edges_X(i); b = edges_X(i+1);
    for j = 1:binNum_Y
        c = edges_Y(j); d = edges_Y(j+1);
        for k = 1:N
            if X(k)>=a && X(k)<=b && Y(k)>=c && Y(k)<=d
                value(i,j) = value(i,j) + GNF_X(k)*GNF_Y(k);
            end
        end
    end
end
p = value/sumsum;

% calculate the entropy
H = 0;
for i = 1:binNum_X
    for j = 1:binNum_Y
        if p(i,j) == 0, continue; end
        H = H - p(i,j)*log(p(i,j));
    end 
end
end







