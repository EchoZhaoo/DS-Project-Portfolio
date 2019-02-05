%read the data
data=load('features_train.txt');

%getting the size of the matrix A
[a c]=size(data);

% plot the figure
figure (1)
for i=1:a
    if data(i,1)==1
        plot(data(i,2), data(i,3), 'b*');
    else
        plot(data(i,2), data(i,3), 'r.');
    end
    hold on;
end
xlabel('Intensity')
ylabel('Symmetry')

%calculate the matrix A
A=data(:,2:3);
A(:,3)=1;

%get the eigenvalue of A'A
eigen=eig(A'*A);
L=max(eigen);
limit=1/L;

%calculate vector b
for i=1:a
    if data(i,1)==1
        b(i,1)=1;
    else
        b(i,1)=-1;
    end
end

%problem dimension
n=3;

%max iteration time
max_time=1e6;

%Steepest descent
%start point and its value and gradient
x(1:n,1)=1;
value(1)=func(x(1:n,1),A,b);
k=1;
d(:,1)=-A'*(A*x(1:n,1)-b);
gradient(1)=norm(d(:,1),2);

%Constant stepsize
%alpha=0.01;
%alpha=1.9e-5;
%alpha=1.8e-5;
alpha=1e-5;

%Stop criteria
while norm(d(:,k),2)/norm(d(:,1),2) > 1e-6 && k <= max_time
    x(1:n,k+1)=x(1:n,k)+alpha*d(:,k); %get the new point
    value(k+1)=func(x(1:n,k+1),A,b); %get the new value
    k=k+1;%update iteration time
    d(:,k)=-A'*(A*x(1:n,k)-b); %next descent direction
    gradient(k)=norm(d(:,k),2);%the new gradient norm
end

%plot the value
figure (2)
plot(value);
xlabel('iteration times');
ylabel('function value');
title('Evolution of the objective function');

%real optimal solution
opt_solution=(A'*A)\(A'*b);
opt_value=func(opt_solution,A,b);

figure (3)
%plot normalized value
norm_value=value/opt_value;
plot(norm_value);
xlabel('iteration times');
ylabel('normalized function value');
title('Evolution of the normalized objective function');
set(gca,'ytick',0:1:15) % set the y axis

figure (4)
%plot the norm of gradient
%plot(1000:sizeof(gradient),gradient(1000:end));
semilogy(gradient);
xlabel('iteration times');
ylabel('2nd-norm of gradient');
title('Evolution of the gradient');

clearvars -except A b limit n a x



