function MI = KNN(X,Y,k,algorithm)
% Estimate mutual information based on entropy estimates from k-nearest
% neighbour distances.
% Input: X (1 x N) -- sample vector
%        Y (1 x N) -- sample vector
%        k -- number of nearest points in the neighborhood
%        algorithm -- type of method to do the estimation of mutual
%        information 
%           algorithm = 1 -- epsilon_i = max(epsilon_x_i, epsilon_y_i)
%           algorithm = 2 -- no epsilon_i
% Output: MI -- estimation of mutual information

Z = [X;Y]';
N = size(X,2);
[n_x, n_y, I] = deal(zeros(N,1));
for i = 1:N
    fprintf('i = %d starts\n',i);
    point = Z(i,:);
    Idx = knnsearch(Z,point,'K',k+1);   % since the joint data set contains the i_th point itself
    Idx = Idx(2:end);
    
    D_x = abs(X(Idx(end)) - point(1));
    D_y = abs(Y(Idx(end)) - point(2));
    D = max(D_x, D_y);
    
    if algorithm == 1
        for j = 1:N
%            fprintf('j = %d starts\n',j);
            if X(j) >= (point(1)-D) && X(j) <= (point(1)+D)
                n_x(i) = n_x(i) + 1;
            end
            if Y(j) >= (point(2)-D) && Y(j) <= (point(2)+D)
                n_y(i) = n_y(i) + 1;
            end
        end
        I(i) = psi(k) - (psi(n_x(i)+1) + psi(n_y(i)+1)) + psi(N);
    elseif algorithm == 2
        for j = 1:N
            if X(j) >= (point(1)-D_x) && X(j) <= (point(1)+D_x)
                n_x(i) = n_x(i) + 1;
            end
            if Y(j) >= (point(2)-D_y) && Y(j) <= (point(2)+D_y)
                n_y(i) = n_y(i) + 1;
            end
        end
        I(i) = psi(k) - (psi(n_x(i)+1) + psi(n_y(i)+1)) + psi(N);
    end      
end
MI = sum(I)/N;
end
