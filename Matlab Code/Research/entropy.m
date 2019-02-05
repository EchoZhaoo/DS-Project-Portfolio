function H = entropy(GNF, binNum, bin)
% Calculate the entropy of variale X based on Fuzzy Histogram Method
% Input: GNF (1 x N) -- membership values of samples X
%        binNum -- number of bins
%        bin (1 x N) -- index of bins that each element is assigned to
% Output: H -- entropy of X

% calculate the probability 
p = zeros(binNum,1);
for i = 1:binNum
    binIdx = find(bin == i);
    p(i) = sum(GNF(binIdx));
end
p = p/sum(p);

% calculate the entropy
H = 0;
for i = 1:binNum
    if p(i) == 0, continue; end
    H = H - p(i)*log(p(i));
end

end

% a = edges_X(10); b = edges_X(11);
% count = 0; value = 0;
% for i = 1:N
%     if X(i)>=a && X(i)<=b
%         count = count + 1;
%         value = value + GNF_X(i);
%     end
% end
% 
% p_1 = value/sum(GNF_X)
% p_2 = count/N
