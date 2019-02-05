%%
% Run the Kernel Perceptron
%
% The parameters received are:
% - X (N x D): Samples, where N is the number of samples, and D the number
% of features
% - y (N x 1): True labels (-1 or +1)
% - sigma (1 x 1): RBF parameter
%
function alphas = KernelPerceptron(X,y,sigma)
%%%% YOUR CODE STARTS HERE
[N,~] = size(X);
alphas = zeros(N,1); % alphas: N x 1
K = zeros(N,N);
for i = 1:N
    for j = 1:N
        K(i,j) = RBF(X(i,:),X(j,:),sigma);
    end
end
y_hat = zeros(N,1); % y_hat = N x 1
count = zeros(N,1);
for iteration = 1:500
    for j = 1:N
        y_hat(j) = sign(sum(K(j,:)*(alphas.*y)));
        if y_hat(j) ~= y(j)
            alphas(j) = alphas(j) + 1;
            count(j) = 1;
        end
    end
    if sum(count) == 0
        break;
    end
end 
%%%%
end

