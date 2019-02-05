function error_rate = ErrorRate(y_pred,y_label)
%%%% YOUR CODE STARTS HERE
[N,~] = size(y_label);
count = 0;
for i = 1:N
    if y_label(i) ~= y_pred(i)
        count = count + 1;
    end
end
error_rate = count/N;
%%%% 
end