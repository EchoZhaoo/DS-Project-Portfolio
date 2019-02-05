m = csvread("result.csv");
f = m(m(:,3)>0,:);

f(:,2) = f(:,2)-1000000*ones(size(f,1),1);

A = sortrows(f);

%partition into 3 parts
X = A(A(:,4)==3,1:3);
Y = A(A(:,4)==2,1:3);
Z = A(A(:,4)==1,1:3);

ind = find(X(:,3)==2);
for i = 1:size(ind,1)
    ix = ind(i);
    g = X(ix,2);
    c_n = X(ix,1);
    g_n = X((X(:,1)==c_n) & (X(:,3)==1),2);

    ix_c = find(Z(:,2)==g);    %index of common child
    Z(ix_c(1), 2) = g_n;       %change
    X((X(:,1)==c_n) & (X(:,3)==1),3) = 0;
    X(ix,3) = 3;
end

X = X(X(:,3)==3,:);



ind2 = find(Y(:,3)==1);
ind3 = ind2(1:2:size(ind2,1));
ind4 = ind2(2:2:size(ind2,1));
for i = 1:size(ind3,1)
    ix1 = ind3(i);  %first
    ix2 = ind4(i);  %second
    g = Y(ix1,2);
    g_n = Y(ix2,2);

    ix_c = find(Z(:,2)==g);    %index of common child
    Z(ix_c(1), 2) = g_n;       %change
    
    Y(ix1,3) = 2;
    Y(ix2,3) = 0;
end


Y = Y(Y(:,3)==2,:);

