%% EE5239   Homework3   Question 2
%% Set environment
clear
formatSpec = '%f %f %f'; 
% Load training set
fileID = fopen('features_train.txt','r');                              
size_trn = [3 inf];                            
trn = fscanf(fileID,formatSpec,size_trn);     
fclose(fileID);

% Load test set
fileID = fopen('features_test.txt','r');                               
size_test = [3 inf];                            
test = fscanf(fileID,formatSpec,size_test);     
fclose(fileID);

n = size(trn,2);                    % 7291
A = [trn(2:3,:)' ones(n,1)];        % Input; 7291 by 3
label = trn(1,:)';                  % 0 ~ 9; 7291 by 1
b = -ones(n,1);                     % 7291 by 1
for i = 1:n
    if label(i) == 1
        b(i) = 1;
    end
end

x = ones(3,1);              % Initialize parameters

ir = 500;
d = -2*A'*(A*x + b);        % Direction; 3 by 1


%% Steepest Descent using constant stepsize rule
for alpha = [.1 .2 .3 .4]
    f_con = zeros(ir+1, 1);
    f_con(1) = F(x(:,1), A, b);
    for i = 1:ir
        x(:,i+1) = ConStep(x(:,i), d, alpha);
        f_con(i+1) = F(x(:,i+1), A, b);
    end
    plot(1:ir+1, f_con);
    hold on
end
hold off
title_text = 'Evolution of the objective funciton \\ Constant Stepsize';
title(sprintf('\\begin{tabular}{c} %s \\end{tabular}', title_text), 'Interpreter', 'latex')
xlabel('Iteration Number', 'Interpreter', 'latex')
ylabel('Objective Values', 'Interpreter', 'latex')
ax = gca;
ax.FontSize = 15;
legend({'$\alpha = 0.1$', '$\alpha = 0.2$', '$\alpha = 0.3$', '$\alpha = 0.4$'}, 'Interpreter', 'latex');
legend('Location','northwest')

%% Steepest Descent using Diminishing Stepsize
x_1 = ones(3,1);
x_2 = ones(3,1);
x_3 = ones(3,1);
f_dim_1 = zeros(ir+1, 1);
f_dim_2 = zeros(ir+1, 1);
f_dim_3 = zeros(ir+1, 1);
f_dim_1(1) = F(x_1(:,1), A, b);
f_dim_2(1) = F(x_2(:,1), A, b);
f_dim_3(1) = F(x_3(:,1), A, b);

for i = 1:ir
    x_1(:,i+1) = ConStep(x_1(:,i), d, 1/i);
    f_dim_1(i+1) = F(x_1(:,i+1), A, b);
    x_2(:,i+1) = ConStep(x_2(:,i), d, 1/(i^2));
    f_dim_2(i+1) = F(x_2(:,i+1), A, b);
    x_3(:,i+1) = ConStep(x_3(:,i), d, 1/sqrt(i));
    f_dim_3(i+1) = F(x_3(:,i+1), A, b);
end

figure
plot(1:ir+1, f_dim_1, '-');
hold on
plot(1:ir+1, f_dim_2, '-.');
hold on
plot(1:ir+1, f_dim_3, '--');
hold off
title_text = 'Evolution of the objective funciton \\ Diminishing Stepsize';
title(sprintf('\\begin{tabular}{c} %s \\end{tabular}', title_text), 'Interpreter', 'latex')
xlabel('Iteration Number', 'Interpreter', 'latex')
ylabel('Objective Values', 'Interpreter', 'latex')
ax = gca;
ax.FontSize = 15;
legend({'$\alpha_r = 1/r$', '$\alpha_r = 1/r^2$', '$\alpha_r = 1/\sqrt{r}$'}, 'Interpreter', 'latex');
legend('Location','northwest')
    
%% Steepest Descent using Armijo Stepsize
x = ones(3,1);
f_armijo = zeros(ir+1, 1);
f_armijo(1) = F(x(:,1), A, b);
for i = 1:ir
    x(:,i+1) = Armijo(x(:,i), d, A, b);
    f_armijo(i+1) = F(x(:,i+1), A, b);
end
figure 
plot(1:ir+1, f_armijo);
title_text = 'Evolution of the objective funciton \\ Armijo Stepsize';
title(sprintf('\\begin{tabular}{c} %s \\end{tabular}', title_text), 'Interpreter', 'latex')
xlabel('Iteration Number', 'Interpreter', 'latex')
ylabel('Objective Values', 'Interpreter', 'latex')
ax = gca;
ax.FontSize = 15;


%% Object function value
function [y] = F(x, A, b)
    y = (norm(A*x-b))^2;
end

%% Constant Stepsize
function [x_next] = ConStep(x, d, alpha)
    x_next = x + alpha*d;
end

%% Armijo Stepsize
function [x_next] = Armijo(x, d, A, b)
    beta = .9;
    sigma = .3;
    s = 1;
    slop1 = sigma*dot(2*A'*(A*x + b), d);
    x_next = x + s*d;
    slop2 = (F(x_next,A,b)-F(x,A,b))/s;
    while(slop1 < slop2)
        s = s*beta;
        x_next = x + s*d;
        slop2 = (F(x_next,A,b)-F(x,A,b))/s;
        if(slop2 == 0)
            break;
        end
    end
end






        